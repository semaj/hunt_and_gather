class School < ActiveRecord::Base
  has_many :buildings, dependent: :destroy
  has_many :rooms, through: :buildings
end
