class UserMailer < ActionMailer::Base
  
  def welcome_email(user)
    setup_email(user)
    @url  = "http://cwin.heroku.com"
    @subject += "Welcome to Constant Win!"
    @content_type = "text/html"
  end
  
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://cwin.heroku.com/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://cwin.heroku.com"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "ADMINEMAIL"
      @subject     = "[CONSTANT WIN] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
