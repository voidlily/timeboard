class AddStudentIdIndexToTimesheets < ActiveRecord::Migration
  def change
    add_index :timesheets, :student_id
  end
end
