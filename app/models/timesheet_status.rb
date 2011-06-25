class TimesheetStatus < ActiveRecord::Base
  belongs_to :timesheet
  scope :current, order("created_on DESC").limit(1)

  #type_regex = /\A(?:(Draft)|(Signed)|(Approved)|(Processed)|(Disapproved))\Z/
  types = %w(Draft Signed Approved Processed Disapproved)

  validates :timesheet, :presence => true
  validates :status, :presence => true,
                     #:format => { :with => type_regex }
                     :inclusion => types
end
