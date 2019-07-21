class SearchesController < ApplicationController

  def show
    @rooms = params[:search].present? ? Room.active.search_near(params[:search]) : Room.active

    @search = @rooms.ransack(params[:q])
    @rooms = @search.result.to_a

    if params[:start_date].present? && params[:end_date].present?
      @rooms.each do |room|
        @rooms.delete(room) if room.unavailable?(params[:start_date], params[:end_date])
      end
    end
  end
end