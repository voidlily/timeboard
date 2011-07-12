class AddAndOutdateTimesheets < ActiveRecord::Base
  def self.process
    date = DueDate.last
    if Date.today == date
      self.send_reminder_emails
    end
  end

  def self.send_reminder_emails
    students = Student.all
    students.each do |student|
      StudentMailer.reminder_email(student).deliver
    end
  end
end
