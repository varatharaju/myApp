class CommonsController < ApplicationController
	def list
		@person_list = Api::Http.api_get("person/","results",session[:user_token])
	end

	def new_person
	end

	def create_person
		@person = Api::Http.api_post("person/",params[:person],"results",session[:user_token])
		if !@person["status"]
			flash[:notice] = @person["error"]
			redirect_to({ action: 'new_person' })
		else
			flash[:notice] = "Person created successfully"
			redirect_to url_for(:controller => :commons, :action => :list)
		end	
	end

	def reports
		@reports = Api::Http.api_get("report/","results",session[:user_token])
	end

	def get_reports
		@reports = Api::Http.api_get("report/?page="+ (params[:page_no].to_i + 1).to_s,"results",session[:user_token])
		respond_to do |format|
		     format.json {
		        render json: {:status => @reports["status"], :error => @reports["error"] , :data => @reports["results"]}
		     }
		end
	end

end
