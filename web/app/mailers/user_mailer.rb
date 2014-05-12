class UserMailer < ActionMailer::Base
  def Signup_confirmation(user_id)
    user = MyApp.db.get_user(user_id)
    mail (
      to: user.email,
      from:"dontreply@myapp.com")
  end
end
