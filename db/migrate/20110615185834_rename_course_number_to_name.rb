class RenameCourseNumberToName < ActiveRecord::Migration
  def up
    rename_column :courses, :course_number, :name
  end

  def down
    rename_column :courses, :name, :course_number
  end
end
