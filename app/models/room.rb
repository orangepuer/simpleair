class Room < ApplicationRecord
  belongs_to :user

  validates :home_type, :room_type, :accommodate, :bed_room, :bath_room, presence: true
end
