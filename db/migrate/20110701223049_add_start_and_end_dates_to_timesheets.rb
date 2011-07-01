class AddStartAndEndDatesToTimesheets < ActiveRecord::Migration
  def change
    add_column :timesheets, :start_date, :date
    add_column :timesheets, :end_date, :date
  end
end
