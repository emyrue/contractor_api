class UserMailer < ApplicationMailer
  def registration_confirmation
    @greeting = "Hello There!"
    mail to: "emyrue@gmail.com"
  end
end
