class UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token
 
	def login
	end

	def verify_login
		@response = Api::Http.api_post("auth/",params[:user],"token")
		if !@response["status"]
			flash[:notice] = @response["error"]
			redirect_to({ action: 'login' })
		else
			session[:user_token] = @response["results"]
			redirect_to url_for(:controller => :commons, :action => :list)
		end		
	end

	def logout			
		reset_session
		redirect_to({ action: 'login' })
	end

end
