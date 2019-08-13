FactoryBot.define do
  factory :guest_review do
    comment { "MyText" }
    star { 1 }
    room { nil }
    reservation { nil }
    guest { nil }
    host { nil }
    type { "GuestReview" }
  end
end
