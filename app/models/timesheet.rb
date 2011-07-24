# == Schema Information
#
# Table name: timesheets
#
#  id            :integer         not null, primary key
#  student_id    :integer
#  created_at    :datetime
#  updated_at    :datetime
#  start_date    :date
#  end_date      :date
#  reopen_reason :string
#

class Timesheet < ActiveRecord::Base
  belongs_to :student
  has_many :timesheet_statuses
  has_many :timesheet_entries
  accepts_nested_attributes_for :timesheet_entries
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  #validates_numericality_of :timesheet_length, :equal_to => 13
  scope :not_late, where(:late => false)

  def status
    entry = TimesheetStatus.current(self.id).first
    entry.nil? ? "Draft" : entry.status
  end

  def open?
    self.draft? || self.disapproved?
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

  def disapproved?
    %w(Disapproved).include?(self.status)
  end

  def sign!
    self.timesheet_statuses.create(:status => "Signed")
  end

  def approve!
    self.timesheet_statuses.create(:status => "Approved")
  end

  def reopen(reason)
    self.timesheet_statuses.create(:status => "Disapproved")
    self.reopen_reason = reason
    self.save
  end

  def process!
    self.timesheet_statuses.create(:status => "Processed")
  end

  def hours
    hours = 0
    self.timesheet_entries.each do |entry|
      hours = hours + entry.hours
    end
    return hours
  end

  private
  
  def timesheet_length
    self.end_date - self.start_date
  end

end

