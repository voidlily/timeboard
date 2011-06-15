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

Factory.define :timesheet do |timesheet|
  timesheet.association :student
end

Factory.sequence :email do |n|
  "testuser-#{n}@example.com"
end

Factory.sequence :account do |n|
  "testuser#{n+3}"
end

Factory.sequence :employee_id do |n|
  "#{n}"
end

Factory.sequence :user do |n|
  Factory(:user, :email => Factory.next(:email),
                 :account => Factory.next(:account),
                 :employee_id => Factory.next(:employee_id))
end
