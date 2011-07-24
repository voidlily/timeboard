class AddAndOutdateTimesheets < ActiveRecord::Base
  def self.process
    date = DueDate.last
    if Date.today >= date
      todays_date = Date.today
      self.mark_outstanding_timesheets_late
      self.add_new_timesheets
      self.increment_due_date
    end
  end

  def self.mark_outstanding_timesheets_late
    # This is pretty bad and is going to slow down as more timesheets are added.
    # Figure out a way to find only drafts
    Timesheet.all.each do |timesheet|
      if timesheet.open?
        timesheet.late = true
        timesheet.save
      end
    end
  end

  # Purely for testing purposes, to be used unless this code is better than add_new_timesheets
  def self.add_new_timesheets_with_date(date)
    students = Student.active
    students.each do |student|
      ts = student.timesheets.create
      ts.start_date = date
      ts.end_date = ts.start_date + 13.days
      if (ts.save)
	(0..13).each do |i|
	  entry = ts.timesheet_entries.create
	  entry.date = ts.start_date + i.days
	  entry.hours = 0
	  entry.save
	end
      end
    end
  end

  def self.add_new_timesheets
    students = Student.active # eventually change to some kind of active scope (for inactive students)
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
