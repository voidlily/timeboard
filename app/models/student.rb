class Student < User
  has_many :timesheets, :dependent => :destroy
end
