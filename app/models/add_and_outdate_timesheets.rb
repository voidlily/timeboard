class AddAndOutdateTimesheets < ActiveRecord::Base
  def self.process
  if(File.exists? "offweek")
    FileUtils.remove "offweek"
    puts "offweek"
  else
    FileUtils.touch "offweek"
    students = Student.all
    todays_date = Date.today
    students.each do |student|
      added_timesheet = Timesheet.new(:student_id => student.id, :start_date => todays_date, :end_date => todays_date + 13.days )
      if(added_timesheet.save)
        (0..13).each do |i|
          next_entry = added_timesheet.timesheet_entries.create(:date => todays_date + i.days, :hours => 0)
        end
      end
    end
    puts "ran"
  end
  end
end
