# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110717230133) do

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.integer  "professor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["name"], :name => "index_courses_on_course_number", :unique => true
  add_index "courses", ["professor_id"], :name => "index_courses_on_professor_id"

  create_table "due_dates", :force => true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holidays", :force => true do |t|
    t.date     "date"
    t.string   "holiday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "holidays", ["date"], :name => "index_holidays_on_date", :unique => true

  create_table "timesheet_entries", :force => true do |t|
    t.integer  "timesheet_id"
    t.date     "date"
    t.decimal  "hours",        :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timesheet_entries", ["timesheet_id", "date"], :name => "index_timesheet_entries_on_timesheet_id_and_date", :unique => true
  add_index "timesheet_entries", ["timesheet_id"], :name => "index_timesheet_entries_on_timesheet_id"

  create_table "timesheet_statuses", :force => true do |t|
    t.integer  "timesheet_id"
    t.string   "status"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timesheet_statuses", ["timesheet_id", "status"], :name => "index_timesheet_statuses_on_timesheet_id_and_status"

  create_table "timesheets", :force => true do |t|
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "reopen_reason"
  end

  add_index "timesheets", ["student_id"], :name => "index_timesheets_on_student_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "account"
    t.string   "email"
    t.string   "employee_id"
    t.boolean  "admin"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.boolean  "active",      :default => true, :null => false
  end

  add_index "users", ["account"], :name => "index_users_on_prism", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
