class Review < ApplicationRecord
  belongs_to :room
  belongs_to :reservation

  validates :star, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  validate :review_does_not_exist, if: Proc.new { |r| r.reservation.present? }

  private

  def review_does_not_exist
    if self.class.where(reservation: reservation).count > 0
      errors.add(:base, 'You have already made a review')
    end
  end
end
