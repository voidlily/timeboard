class AddAndOutdateTimesheets < ActiveRecord::Base
  def self.process
    date = DueDate.date
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
	timsheet.late!
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
    date = DueDate.date
    while Date.today > date
      date += 2.weeks
    end
    date_obj = DueDate.last
    date_obj.date = date
    date_obj.save
  end

  # Adds missing timesheets. Should be run if students are added and expected to fill out timesheets right away.
  def self.add_missing_timesheets
    due_date = DueDate.date
    start_date = date - 13.days
    students = Student.active
    students.each do |student|
      if student.current_timesheet.nil?
        timesheet = Timesheet.new(:student_id => student.id, :start_date => start_date, :end_date => due_date)
        if (timesheet.save)
          (0..13).each do |i|
            entry = timesheet.timesheet_entries.create(:date => start_date + i.days, :hours => 0)
          end
        end
      end
    end
  end

  # Automatically run when a new student is added through the controller.
  def self.add_missing_timesheets(student)
    due_date = DueDate.date
    start_date = date - 13.days
    if student.current_timesheet.nil?
      timesheet = Timesheet.new(:student_id => student.id, :start_date => start_date, :end_date => due_date)
      if (timesheet.save)
        (0..13).each do |i|
          entry = timesheet.timesheet_entries.create(:date => start_date + i.days, :hours => 0)
        end
      end
    end
  end

end
