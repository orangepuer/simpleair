class ReservationsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def create
    room = Room.find(params[:room_id])

    reservation = current_user.reservations.new(reservations_params.merge(room: room))

    if reservation.save
      flash[:notice] = 'Booked Successfully'
    else
      helpers.flash_error_messages(reservation)
    end

    redirect_to room
  end

  def your_trips
    @trips = current_user.reservations
    @guest_review = current_user.guest_reviews.new
  end

  def your_reservations
    @rooms = current_user.rooms
    @host_review = current_user.host_reviews.new
  end

  private

  def reservations_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end