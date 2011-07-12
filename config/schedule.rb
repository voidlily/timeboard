# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

set :environment, :development
set :output, '/home/andrew/seniordesign/timeboard/timeboard/whenever.log'

#every :thursday, :at => "00:05" do
every 1.minute do
  runner "AddAndOutdateTimesheets.process"
end

every :wednesday, :at => "12:00" do
  runner "SendReminderEmail.process"
end

# Learn more: http://github.com/javan/whenever
