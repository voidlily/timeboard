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

ActiveRecord::Schema.define(:version => 20110613191548) do

  create_table "courses", :force => true do |t|
    t.string   "course_number"
    t.integer  "professor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timesheet_entries", :force => true do |t|
    t.integer  "timesheet_id"
    t.date     "date"
    t.decimal  "hours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timesheets", :force => true do |t|
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "prism"
    t.string   "email"
    t.string   "employee_id"
    t.boolean  "admin"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["prism"], :name => "index_users_on_prism", :unique => true

end
