class HostNotificationMailerPreview < ActionMailer::Preview
  def reservation
    HostNotificationMailer.reservation(Reservation.first)
  end
end