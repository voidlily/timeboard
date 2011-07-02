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

class TimesheetEntry < ActiveRecord::Base
  belongs_to :timesheet

  validates :date, :presence => true
  validates :hours, :presence => true

  validates_numericality_of :hours, :greater_than_or_equal_to => 0
end

