class Room < ActiveRecord::Base
  belongs_to :building
  attr_accessible :building_id, :name, :food

  def has_food?
    return self.food
  end
end
