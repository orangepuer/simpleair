class PhotosController < ApplicationController
  before_action :set_room
  before_action :authenticate_user!

  def create
    @room.photos.attach(params[:photos]) if params[:photos]

    redirect_back(fallback_location: request.referer, notice: 'Saved')
  end

  def destroy
    @photos = @room.photos
    @photos.find(params[:id]).purge if params[:id]

    respond_to :js
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end
end