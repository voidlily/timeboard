class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.date :date
      t.string :holiday

      t.timestamps
    end
    add_index :holidays, :date, :unique => true
  end
end
