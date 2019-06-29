require 'rails_helper'

RSpec.describe GuestReview, type: :model do
  it { should belong_to :guest }
end
