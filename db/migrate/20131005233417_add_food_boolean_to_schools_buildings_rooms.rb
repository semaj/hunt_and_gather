class AddFoodBooleanToSchoolsBuildingsRooms < ActiveRecord::Migration
  def change
    add_column :schools, :food, :boolean, :default => false
    add_column :buildings, :food, :boolean, :default => false
    add_column :rooms, :food, :boolean, :default => false
  end
end
