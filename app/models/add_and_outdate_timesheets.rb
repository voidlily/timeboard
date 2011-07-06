class AddAndOutdateTimesheets < ActiveRecord::Base
  def self.process
    date = DueDate.last
    if Date.today >= date
      students = Student.all # eventually change to some kind of active scope (for inactive students)
      todays_date = Date.today
      students.each do |student|
        added_timesheet = Timesheet.new(:student_id => student.id, :start_date => todays_date, :end_date => todays_date + 13.days )
        if(added_timesheet.save)
          (0..13).each do |i|
            next_entry = added_timesheet.timesheet_entries.create(:date => todays_date + i.days, :hours => 0)
          end
        end
      end
      while Date.today > date
        date += 2.weeks
      end
      date.save
    end
  end
end
