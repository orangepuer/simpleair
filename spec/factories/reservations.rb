FactoryBot.define do
  factory :reservation do
    user { nil }
    room { nil }
    start_date { "2019-06-10 14:42:20" }
    end_date { "2019-06-10 14:42:20" }
    price { 1 }
    total { 1 }
  end
end
