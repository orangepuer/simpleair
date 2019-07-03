class GuestReview < Review
  belongs_to :guest, class_name: 'User'

  before_validation :set_room, :set_host, if: Proc.new { |a| a.reservation.present? }

  private

  def set_room
    self.room = reservation.room
  end

  def set_host
    self.host_id = reservation.room.user.id
  end
end