class Review < ApplicationRecord
  belongs_to :room
  belongs_to :reservation

  validates :star, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
