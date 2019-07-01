class HostReview < Review
  belongs_to :host, class_name: 'User'

  before_validation :set_room, :set_guest, if: Proc.new { |a| a.reservation.present? }

  private

  def set_room
    self.room = reservation.room
  end

  def set_guest
    self.guest_id = reservation.user.id
  end
end