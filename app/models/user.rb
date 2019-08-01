class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :rooms
  has_many :reservations
  has_many :guest_reviews, foreign_key: :guest_id
  has_many :host_reviews, foreign_key: :host_id

  validates :fullname, presence: true, length: {maximum: 50}

  def host?(room)
    rooms.exists?(room.id)
  end
end
