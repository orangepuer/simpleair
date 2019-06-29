require 'rails_helper'

RSpec.describe HostReview, type: :model do
  it { should belong_to :host }
end
