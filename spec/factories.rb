Factory.define :user do |user|
  user.name "Test User"
  user.email "testuser@example.com"
  user.account "testuser3"
  user.employee_id "000000"
end

Factory.define :student do |student|
  student.name "Test Student"
  student.email "teststudent@example.com"
  student.account "teststudent3"
  student.employee_id "333333"
end

Factory.define :professor do |professor|
  professor.name "Test Professor"
  professor.email "testprofessor@example.com"
  professor.account "testprofessor3"
end

Factory.define :timesheet do |timesheet|
  timesheet.association :student
end

Factory.define :course do |course|
  course.name "TEST1000"
end

Factory.sequence :email do |n|
  "testuser-#{n}@example.com"
end

Factory.sequence :account do |n|
  "testuser#{n+3}"
end

Factory.sequence :employee_id do |n|
  "#{100000 + n}"
end

Factory.sequence :user do |n|
  Factory(:user, :email => Factory.next(:email),
                 :account => Factory.next(:account),
                 :employee_id => Factory.next(:employee_id))
end

Factory.sequence :student do |n|
  Factory(:student, :email => Factory.next(:email),
                    :account => Factory.next(:account),
                    :employee_id => Factory.next(:employee_id))
end

Factory.sequence :course do |n|
  Factory(:course, :name => "TEST#{1000+n}")
end
