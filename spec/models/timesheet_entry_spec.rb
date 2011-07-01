# == Schema Information
#
# Table name: timesheet_entries
#
#  id           :integer         not null, primary key
#  timesheet_id :integer
#  date         :date
#  hours        :decimal(, )     default(0.0), not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe TimesheetEntry do
  #Timesheet entries are automatically created every 2 weeks
  #with a new timesheet at maintenance
  pending "add some examples to (or delete) #{__FILE__}"
end

