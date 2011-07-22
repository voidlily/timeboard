class DefaultValueForUserActive < ActiveRecord::Migration
  def up
    User.all.each do |user|
      user.active |= true
      user.save
    end
    change_column :users, :active, :boolean, :null => false, :default => true
  end

  def down
    change_column :users, :active, :boolean, :null => true, :default => nil
  end
end
