class AddIndicesToCourses < ActiveRecord::Migration
  def change
    add_index :courses, :professor_id
    add_index :courses, :course_number, :unique => true
  end
end
