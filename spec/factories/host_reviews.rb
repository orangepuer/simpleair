FactoryBot.define do
  factory :host_review do
    comment { "MyText" }
    star { 1 }
    room { nil }
    reservation { nil }
    guest { nil }
    host { nil }
    type { "HostReview" }
  end
end
