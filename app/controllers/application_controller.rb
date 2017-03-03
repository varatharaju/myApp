require 'httparty'
require 'json'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :check_session, except: ["login","verify_login","logout"]
  skip_before_filter :verify_authenticity_token

  private
  def check_session
  	if session[:user_token].blank?
  		reset_session
		redirect_to url_for(:controller => :users, :action => :login)
	end
  end
end
