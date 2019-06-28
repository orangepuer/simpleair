FactoryBot.define do
  factory :review do
    comment { "MyText" }
    star { 1 }
    room { nil }
    reservation { nil }
    guest { nil }
    host { nil }
    type { "" }
  end
end
