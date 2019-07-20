class PagesController < ApplicationController
  def home
    @rooms = Room.active.limit(3)
  end
end
