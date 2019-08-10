class SearchesController < ApplicationController

  def show
    address = params[:search]

    if address.blank? || helpers.address_valid?(address)
      @rooms = address.blank? ? Room.active : Room.active.search_near(address)
      @search = @rooms.ransack(params[:q])
      @rooms = @search.result.to_a
      @rooms = Room.delete_unavailable_room(@rooms, params[:start_date], params[:end_date])
    else
      redirect_to root_path, alert: 'Address is not valid'
    end
  end
end