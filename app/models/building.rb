class Building < ActiveRecord::Base
  belongs_to :school
  has_many :rooms, dependent: :destroy
  attr_accessible :school_id, :name, :food

  def has_food?
    return self.food || self.rooms.any? {|r| r.has_food? }
  end
end
