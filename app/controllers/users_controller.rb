class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @guest_reviews = GuestReview.where(host_id: @user)
    @host_reviews = HostReview.where(guest_id: @user)
  end
end