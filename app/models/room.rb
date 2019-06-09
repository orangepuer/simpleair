class Room < ApplicationRecord
  belongs_to :user

  has_many_attached :photos

  validates :home_type, :room_type, :accommodate, :bedroom_amount, :bathroom_amount, presence: true

  def data_prepared?
    listing_name.present? && address.present? && price.present? && photos.attached?
  end
end
