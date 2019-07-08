require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to :room }
  it { should belong_to :reservation }

  it { should validate_numericality_of(:star).only_integer }
  it { should validate_numericality_of(:star).is_greater_than_or_equal_to(1) }
  it { should validate_numericality_of(:star).is_less_than_or_equal_to(5) }
end
