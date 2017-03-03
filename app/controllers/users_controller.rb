class UsersController < ApplicationController
	API_BASE_URL = "http://fullstacktest.datawrkz.com/api/v1/auth/"   
	skip_before_filter :verify_authenticity_token
 
	def login

	end

	def verify_login
		@response = HTTParty.post(API_BASE_URL, 
				    :body => { :username => params[:user][:name], 
				               :password => params[:user][:password]
				             }.to_json,
				    :headers => { 'Content-Type' => 'application/json' } )
		if @response.parsed_response.has_key?("status_code")
			error = @response.parsed_response.collect{|key,value| (key + ":" + value[0]) if value.class == Array}
			flash[:notice] = error.compact.join(",\n")
			redirect_to({ action: 'login' })
		else
			session[:user_token] = @response.parsed_response["token"]
			redirect_to url_for(:controller => :commons, :action => :list)
		end		
	end

	def logout			
		reset_session
		redirect_to({ action: 'login' })
	end

end
