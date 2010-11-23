# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

  layout 'base'
  
  # render new.erb.html
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = "Logged in successfully"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end

  # This method handles  app logout when user is already logged out of Facebook 
  def fb_logout_link(text,url,*args)
    js = update_page do |page|
      page.call "FB.Connect.logoutAndRedirect",url
      # When session is valid, this call is meaningless, since we already redirect
      # When session is invalid, it will log the user out of the system.
      page.redirect_to url # You can use any *string* based path here
    end
    link_to_function text, js, *args
  end
  
end
