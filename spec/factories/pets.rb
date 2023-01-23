FactoryBot.define do
  factory :pet do
    nome { Faker::Creature::Dog.name }
    especie { Faker::Creature::Dog.breed }
    raca { Faker::Creature::Dog.gender }
    association :cliente
  end
end
