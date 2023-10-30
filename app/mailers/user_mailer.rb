class UserMailer < ApplicationMailer
  default from: 'notitications@example.com'

  def event_email
    @user = params[:user]
    @title = params[:title]
    @body = params[:body]
    mail(to: @user.email, subject: @title)
  end

end
