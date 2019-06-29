require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :rooms }
  it { should have_many :reservations }
  it { should have_many :guest_reviews }
  it { should have_many :host_reviews }

  it { should validate_presence_of :fullname }

  it { should validate_length_of(:fullname).is_at_most(50) }
end