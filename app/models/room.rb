class Room < ApplicationRecord
  belongs_to :user

  validates :home_type, :room_type, :accommodate, :bedroom_amount, :bathroom_amount, presence: true
end
