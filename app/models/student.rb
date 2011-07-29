# == Schema Information
#
# Table name: users
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  account     :string(255)
#  email       :string(255)
#  employee_id :string(255)
#  admin       :boolean
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  course_id   :integer
#

class Student < User
  has_many :timesheets, :dependent => :destroy
  belongs_to :course
 attr_accessible :name, :account, :email, :employee_id, :admin, :type, :course_id, :active
  #
  # This will figure out which timesheet is the most
  # current one, based on the end_date of the timesheet
  # and the current due date.
  #
  def current_timesheet
    self.timesheets.select { |ts| ts.status == "Draft" }.each do |ts|
      if ts.end_date == DueDate.date
	      return ts
      end
    end
    return nil
  end
end

