class Building < ActiveRecord::Base
  belongs_to :school
  has_many :rooms, dependent: :destroy
end
