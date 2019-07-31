# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    guest_abilities

    can :create, [Room, Reservation, Review]
    can :update, Room, user: user
    can :destroy, [Room, Reservation, Review], user: user

    can :listing, Room, user: user
    can :pricing, Room, user: user
    can :description, Room, user: user
    can :photo_upload, Room, user: user
    can :amenities, Room, user: user
    can :location, Room, user: user

    can :your_trips, Reservation, user: user
    can :your_reservations, Reservation, user: user
  end

  def admin_abilities
    can :manage, :all
  end
end
