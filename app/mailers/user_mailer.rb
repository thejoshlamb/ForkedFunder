class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def activation_needed_email(user)
    @user = user
    @url = "http://0.0.0.0:3000/users/#{user.activation_token}/activate"

    mail(to: @user.email,
          subject: "Welcome to CrowdFunder!")
  end

  def activation_success_email(user)    
    @user = user
    @url = "http://0.0.0.0:3000/login"

    mail(to: @user.email,
          subject: "Your account is now activated")
  end
end
