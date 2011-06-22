class CreateDueDates < ActiveRecord::Migration
  def change
    create_table :due_dates do |t|
      t.date :date

      t.timestamps
    end
  end
end
