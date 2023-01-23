FactoryBot.define do
  factory :servico do
    titulo { Faker::Lorem.sentence }
    preco { Faker::Commerce.price }
    data_agendamento { Faker::Date.forward(days: 30) }
    association :pet
  end
end
