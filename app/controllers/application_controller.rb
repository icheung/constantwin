# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  # Facebook Login
  before_filter :set_facebook_session
  helper_method :facebook_session
  
  # Be sure to include AuthenticationSystem in Application Controller
  # for RESTful Authentication
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  rescue_from Facebooker::Session::SessionExpired, :with => :facebook_session_expired

  def facebook_session_expired
    clear_facebook_session_information
    clear_fb_cookies!
    reset_session # i.e. logout the user
    create_new_facebook_session_and_redirect!
    flash[:notice] = "Your Facebook session has expired."
    redirect_to root_url
  end
  
end
