require 'httparty'
require 'json'

module Api
	module Http

		@@base_uri = "http://fullstacktest.datawrkz.com/api/v1/"
		@@headers = { 'Content-Type' => 'application/json' }

		def self.api_get(url,attr,token=nil)
			result = {}
			@@headers["authorization"] = token unless token.blank?
			res = HTTParty.get((@@base_uri+url),:headers =>  @@headers)
			return self.parse_result(res,attr)
		end

		def self.api_post(url,params,attr,token=nil)
			@@headers["authorization"] = token unless token.blank?
			res = HTTParty.post((@@base_uri+url), 
					    :body => params.to_json,
					    :headers =>  @@headers)
			return self.parse_result(JSON.parse(res.body),attr)
		end

		def self.parse_result(res,attr)
			result = {}
			if res.has_key?("status_code")
				error = res.collect{|key,value| (key + " => " + value[0]) if (key != "status_code")}
				result["status"] = false
				result["error"] = error.compact.join("\n")
				result["results"] = []
			else
				result["status"] = true
				result["error"] = ""
				result["results"] = res[attr]
			end	
			result
		end 

	end
end 