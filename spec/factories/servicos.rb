FactoryBot.define do
  factory :service do
    title { Faker::Lorem.sentence }
    price { 50 }
    scheduled_date { Faker::Time.between(from: DateTime.now, to: DateTime.now + 30, format: :default) }
    association :pet
  end
end
