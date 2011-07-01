# == Schema Information
#
# Table name: timesheet_statuses
#
#  id           :integer         not null, primary key
#  timesheet_id :integer
#  status       :string(255)
#  reason       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class TimesheetStatus < ActiveRecord::Base
  belongs_to :timesheet
  scope :current, lambda { |timesheet_id|
    where("timesheet_id = ?", timesheet_id.to_i).order("created_at DESC").limit(1)
  }

  types = %w(Draft Signed Approved Processed Disapproved)

  validates :timesheet, :presence => true
  validates :status, :presence => true,
                     :inclusion => types
end

