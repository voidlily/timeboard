class Professor < User
  has_many :courses
  has_many :students, :through => :courses
  has_many :timesheets, :through => :students
end
