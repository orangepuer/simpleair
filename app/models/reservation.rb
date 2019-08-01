class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :host_review
  has_one :guest_review

  validates :start_date, :end_date, presence: true
  validate :end_date_more, if: Proc.new { |a| a.start_date.present? && a.end_date.present? }
  validate :user_is_not_host

  before_save :set_price, :set_total

  default_scope { order(start_date: :desc) }

  private

  def days_count
    @days_count ||= end_date.to_date - start_date.to_date + 1
  end

  def end_date_more
    if days_count < 1
      errors.add(:base, 'End date should be more of start date')
    end
  end

  def set_price
    self.price = room.price
  end

  def set_total
    self.total = price * days_count
  end

  def user_is_not_host
    if user.host?(room)
      errors.add(:base, 'You can not reserve your own room')
    end
  end
end
