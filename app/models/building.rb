class Building < ActiveRecord::Base
  belongs_to :school
  has_many :rooms, dependent: :destroy
  attr_accessible :school_id, :name, :food

  def has_food?
    if self.rooms.empty?
      return self.food
    else
      return self.rooms.any? {|r| r.has_food? }
    end
  end
end
