class GuestReviewsController < ApplicationController
  before_action :set_reservation, only: [:create]
  before_action :authenticate_user!

  def create
    if @reservation.guest_review.blank?
      guest_review = current_user.guest_reviews.new(guest_review_params)

      if guest_review.save
        flash[:notice] = 'Review created'
      else
        helpers.flash_error_messages(guest_review)
      end
    else
      flash[:alert] = 'You have already made a review'
    end

    redirect_back(fallback_location: request.referer)
  end

  def destroy
    guest_review = GuestReview.find(params[:id])
    guest_review.destroy

    redirect_back(fallback_location: request.referer, notice: 'Removed')
  end


  private

  def set_reservation
    @reservation = Reservation.find(guest_review_params[:reservation_id])
  end

  def guest_review_params
    params.require(:guest_review).permit(:comment, :star, :reservation_id)
  end
end