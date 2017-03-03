class CommonsController < ApplicationController
	def list
			headers = { 
			  "authorization" => session[:user_token],
			  'Content-Type' => 'application/json'
			}

			@person_list = HTTParty.get(
			  "http://fullstacktest.datawrkz.com/api/v1/person/",
			  :headers => headers
			) 
	end

	def new_person
	end

	def create_person
		headers = { 
		  "authorization" => session[:user_token],
		  'Content-Type' => 'application/json'
		}
		@person = HTTParty.post(
		  "http://fullstacktest.datawrkz.com/api/v1/person/",
		  :body => params[:person].to_json,
		  :headers => headers
		)
		if @person.parsed_response.has_key?("status_code")
			error = @person.parsed_response.collect{|k,v| v[0] if v.class == Array}
			flash[:notice] = "Please enter all fields"
			redirect_to({ action: 'new_person' })
		else
			flash[:notice] = "Person created successfully"
			redirect_to url_for(:controller => :commons, :action => :list)
		end	
	end

	def reports
		url = "http://fullstacktest.datawrkz.com/api/v1/report/"
		headers = { 
			  "authorization" => session[:user_token],
			  'Content-Type' => 'application/json'
			}

			@reports = HTTParty.get(
			  "http://fullstacktest.datawrkz.com/api/v1/report/",
			  :headers => headers
			)
	end

	def get_reports
		url = "http://fullstacktest.datawrkz.com/api/v1/report/page="+ (params[:page_no].to_i + 1).to_s
		headers = { 
			  "authorization" => session[:user_token],
			  'Content-Type' => 'application/json'
			}

		@reports = HTTParty.get(
		  "http://fullstacktest.datawrkz.com/api/v1/report/",
		  :headers => headers
		)
		respond_to do |format|
		     format.json { 
		        render json: {:data => @reports.parsed_response["results"]}
		     }
		end
	end

end
