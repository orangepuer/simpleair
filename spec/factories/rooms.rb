FactoryBot.define do
  factory :room do
    home_type { "MyString" }
    room_type { "MyString" }
    accommodate { 1 }
    bedroom_amount { 1 }
    bathroom_amount { 1 }
    listing_name { "MyString" }
    summary { "MyText" }
    address { "MyString" }
    price { 1 }
    is_tv { false }
    is_kitchen { false }
    is_air { false }
    is_heating { false }
    is_internet { false }
    active { false }
    user { nil }
  end
end
