class Services::HostNotification
  def send_reservation(reservation)
    HostNotificationMailer.reservation(reservation).deliver_later
  end
end