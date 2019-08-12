class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :host_review
  has_one :guest_review

  validates :start_date, :end_date, presence: true
  validate :end_date_more, if: Proc.new { |r| r.start_date.present? && r.end_date.present? }
  validate :user_is_not_host, if: Proc.new { |r| r.room.present? }
  validate :room_available, if: Proc.new { |r| r.start_date.present? && r.end_date.present? }

  before_save :set_price, :set_total
  after_commit :notify_host, :notify_guest, :on => :create

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

  def notify_host
    HostReservationJob.perform_later(self)
  end

  def notify_guest
    GuestReservationJob.perform_later(self)
  end

  def user_is_not_host
    if user.host?(room)
      errors.add(:base, 'You can not reserve your own room')
    end
  end

  def room_available
    unless room.available?(start_date, end_date)
      errors.add(:base, 'This date is not available, please check the booking date entered')
    end
  end
end
