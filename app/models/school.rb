class School < ActiveRecord::Base
  has_many :buildings, dependent: :destroy
  has_many :rooms, through: :buildings
  attr_accessible :name, :location, :food

  def has_food?
    if self.buildings.empty?
      return self.food
    else
      return self.buildings.any? {|b| b.has_food? }
    end
  end
end
