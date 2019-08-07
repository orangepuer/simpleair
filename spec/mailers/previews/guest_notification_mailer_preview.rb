class GuestNotificationMailerPreview < ActionMailer::Preview
  def reservation
    GuestNotificationMailer.reservation(Reservation.first)
  end
end