class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    room = Room.find(params[:room_id])

    reservation = current_user.reservations.new(reservations_params.merge(room: room))

    if reservation.save
      flash[:notice] = 'Booked Successfully'

      redirect_to room
    else
      helpers.flash_error_messages(reservation)

      redirect_to room
    end
  end

  def your_trips
    @trips = current_user.reservations
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