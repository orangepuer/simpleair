class Services::GuestNotification
  def send_reservation(reservation)
    GuestNotificationMailer.reservation(reservation).deliver_later
  end
end