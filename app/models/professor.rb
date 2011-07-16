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

class Professor < User
  attr_accessible :name, :account, :email, :employee_id, :admin, :type, :course_id, :active
  has_many :courses
  has_many :students, :through => :courses
  has_many :timesheets, :through => :students
end

