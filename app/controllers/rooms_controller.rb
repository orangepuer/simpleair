class RoomsController < ApplicationController
  before_action :set_room, except: [:index, :new, :create]
  before_action :set_photos, only: [:show, :photo_upload]
  before_action :authenticate_user!, except: [:show]

  authorize_resource

  def index
    @rooms = current_user.rooms
  end

  def show
    @guest_reviews = @room.guest_reviews
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new(room_params)

    if @room.save
      redirect_to listing_room_path(@room), notice: 'Saved...'
    else
      helpers.flash_error_messages(@room)
      render :new
    end
  end

  def update
    if @room.update(room_params)
      flash[:notice] = 'Saved...'
    else
      helpers.flash_error_messages(@room)
    end

    redirect_back(fallback_location: request.referer)
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
  end

  def amenities
  end

  def location
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def set_photos
    @photos = @room.photos
  end

  def room_params
    params.require(:room).permit(:home_type, :room_type, :accommodate, :bedroom_amount,
                                 :bathroom_amount, :listing_name, :summary, :address, :price,
                                 :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :active)
  end
end
