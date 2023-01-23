FactoryBot.define do
  factory :servico do
    titulo { Faker::Lorem.sentence }
    preco { 50 }
    data_agendamento { Faker::Time.between(from: DateTime.now, to: DateTime.now + 30, format: :default) }
    association :pet
  end
end
