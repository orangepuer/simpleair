class HostReviewsController < ApplicationController
  before_action :set_reservation, only: [:create]
  before_action :authenticate_user!

  authorize_resource

  def create
    if @reservation.host_review.blank?
      host_review = current_user.host_reviews.new(host_review_params)

      if host_review.save
        flash[:notice] = 'Review created'
      else
        helpers.flash_error_messages(host_review)
      end
    else
      flash[:alert] = 'You have already made a review'
    end

    redirect_back(fallback_location: request.referer)
  end

  def destroy
    host_review = HostReview.find(params[:id])
    host_review.destroy

    redirect_back(fallback_location: request.referer, notice: 'Removed')
  end


  private

  def set_reservation
    @reservation = Reservation.find(host_review_params[:reservation_id])
  end

  def host_review_params
    params.require(:host_review).permit(:comment, :star, :reservation_id)
  end
end