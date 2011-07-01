# == Schema Information
#
# Table name: timesheets
#
#  id         :integer         not null, primary key
#  student_id :integer
#  created_at :datetime
#  updated_at :datetime
#  start_date :date
#  end_date   :date
#

class Timesheet < ActiveRecord::Base
  belongs_to :student
  has_many :timesheet_statuses
  has_many :timesheet_entries

  def status
    entry = TimesheetStatus.current(self.id).first
    entry.nil? ? "Draft" : entry.status
  end

  def status_obj
    self.timesheet_statuses.current[0]
  end

  def draft?
    self.status == "Draft"
  end

  def signed?
    %w(Signed Approved Processed).include?(self.status)
  end

  def signed_exactly?
    self.status == "Signed"
  end

  def approved?
    %w(Approved Processed).include?(self.status)
  end

  def approved_exactly?
    self.status == "Approved"
  end

  def processed?
    %w(Processed).include?(self.status)
  end

  def sign!
    self.timesheet_statuses.create(:status => "Signed")
  end

  def approve!
    self.timesheet_statuses.create(:status => "Approved")
  end

  def process!
    self.timesheet_statuses.create(:status => "Processed")
  end
end

