class Timesheet < ActiveRecord::Base
  belongs_to :student
  has_many :timesheet_statuses
end
