require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to :room }
  it { should belong_to :reservation }
end
