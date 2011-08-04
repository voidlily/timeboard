class StudentMailer < ActionMailer::Base
  default :from => "from@example.com"

  def reminder_email(user)
    @user = user
    @url = "http://example.com"
    mail(:to => user.email,
         :subject => "Timesheet reminder")
  end
end
