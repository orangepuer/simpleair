require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :fullname }
  it { should validate_length_of(:fullname).is_at_most(50) }
end