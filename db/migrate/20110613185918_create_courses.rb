class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_number
      t.integer :professor_id

      t.timestamps
    end
  end
end
