# == Schema Information
#
# Table name: timesheet_entries
#
#  id           :integer         not null, primary key
#  timesheet_id :integer
#  date         :date
#  hours        :decimal(, )
#  created_at   :datetime
#  updated_at   :datetime
#

class TimesheetEntry < ActiveRecord::Base
end

