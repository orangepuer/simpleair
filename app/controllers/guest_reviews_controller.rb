class GuestReviewsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def create
    guest_review = current_user.guest_reviews.new(guest_review_params)

    if guest_review.save
      flash[:notice] = 'Review created'
    else
      helpers.flash_error_messages(guest_review)
    end

    redirect_back(fallback_location: request.referer)
  end

  def destroy
    guest_review = GuestReview.find(params[:id])
    guest_review.destroy

    redirect_back(fallback_location: request.referer, notice: 'Removed')
  end

  private

  def guest_review_params
    params.require(:guest_review).permit(:comment, :star, :reservation_id)
  end
end