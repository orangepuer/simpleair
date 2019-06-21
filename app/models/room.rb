class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations

  has_many_attached :photos

  validates :home_type, :room_type, :accommodate, :bedroom_amount, :bathroom_amount, presence: true

  after_validation :geocode, if: lambda{ |obj| obj.address_changed? }

  geocoded_by :address

  def data_prepared?
    listing_name.present? && address.present? && price.present? && photos.attached?
  end

  def reserved_dates
    today = Date.today
    reservations.where('start_date >= ? OR end_date >=?', today, today)
  end
end
