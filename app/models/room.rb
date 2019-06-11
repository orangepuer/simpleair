class Room < ApplicationRecord
  belongs_to :user

  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: lambda{ |obj| obj.address_changed? }

  validates :home_type, :room_type, :accommodate, :bedroom_amount, :bathroom_amount, presence: true

  def data_prepared?
    listing_name.present? && address.present? && price.present? && photos.attached?
  end
end
