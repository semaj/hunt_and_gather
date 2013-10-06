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

  def find_food
    if self.has_food?
      food_string = "There's food in: "
      self.buildings.each do |b|
        if b.has_food?
          food_string = food_string + b.name + ": "
          b.rooms.each do |r|
            if r.has_food
              food_string = food_string + r.name + " - "
            end
          end
          food_string = food_string + " | "
        end
      end
    else
      food_string = "No, sorry!"
    end
    return food_string
  end

end
