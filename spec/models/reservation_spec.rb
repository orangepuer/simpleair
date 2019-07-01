require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { should belong_to :user }
  it { should belong_to :room }
  it { should have_one :host_review }
  it { should have_one :guest_review }

  it { should validate_presence_of :start_date }
  it { should validate_presence_of :end_date }
end
