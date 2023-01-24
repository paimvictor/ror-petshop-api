FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    species { Faker::Creature::Dog.breed }
    breed { Faker::Creature::Dog.gender }
    association :client
  end
end
