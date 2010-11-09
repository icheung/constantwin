class UserMailer < ActionMailer::Base
  
  def welcome_email(user)
    setup_email(user)
    @url  = "http://example.com/login"
    @subject += "Welcome to Constant Win!"
  end
  
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://localhost:3000/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://YOURSITE/"
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
