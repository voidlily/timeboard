class Student < User
  has_many :timesheets, :dependent => :destroy
  belongs_to :course
end
