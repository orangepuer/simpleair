require 'rails_helper'

RSpec.describe Room, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :home_type }
  it { should validate_presence_of :room_type }
  it { should validate_presence_of :accommodate }
  it { should validate_presence_of :bed_room }
  it { should validate_presence_of :bath_room }
end
