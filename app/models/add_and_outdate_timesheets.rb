class AddAndOutdateTimesheets < ActiveRecord::Base
  def self.process
    date = DueDate.last
    if Date.today >= date
      todays_date = Date.today
      self.add_new_timesheets
      self.increment_due_date
    end
  end

  def self.add_new_timesheets
    students = Student.all # eventually change to some kind of active scope (for inactive students)
    students.each do |student|
      added_timesheet = Timesheet.new(:student_id => student.id, :start_date => todays_date, :end_date => todays_date + 13.days )
      if(added_timesheet.save)
        (0..13).each do |i|
          next_entry = added_timesheet.timesheet_entries.create(:date => todays_date + i.days, :hours => 0)
        end
      end
    end
  end

  def self.increment_due_date
    while Date.today > date
      date += 2.weeks
    end
    date.save
  end
end
