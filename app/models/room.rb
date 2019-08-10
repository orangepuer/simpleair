class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_many :guest_reviews

  has_many_attached :photos

  validates :home_type, :room_type, :accommodate, :bedroom_amount, :bathroom_amount, presence: true

  after_validation :geocode, if: lambda{ |obj| obj.address_changed? }

  scope :active, -> { where(active: true) }

  geocoded_by :address

  def self.search_near(address)
    near(address, 5, order: 'distance')
  end

  def available?(start_date, end_date)
    reserved_date = self.reservations.where('(start_date <= ? AND end_date >= ?) OR
                                          (start_date >= ? AND start_date <= ?) OR
                                          (end_date >= ? AND end_date <= ?)',
                                          start_date, end_date,
                                          start_date, end_date,
                                          start_date, end_date).limit(1)

    reserved_date.blank?
  end

  def self.delete_unavailable_room(rooms, start_date, end_date)
    if start_date.present? && end_date.present?
      start_date = start_date.to_datetime
      end_date = end_date.to_datetime

      rooms.delete_if { |room| !room.available?(start_date, end_date) }
    end

    rooms
  end

  def average_rating
    guest_reviews.present? ? guest_reviews.average(:star).round(1, half: :up) : 0
  end

  def data_prepared?
    listing_name.present? && address.present? && price.present? && photos.attached?
  end

  def reserved_dates
    today = Date.today
    reservations.where('start_date >= ? OR end_date >=?', today, today)
  end
end
