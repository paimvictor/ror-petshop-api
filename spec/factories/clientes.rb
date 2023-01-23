FactoryBot.define do
  factory :cliente do
    nome { Faker::Name.name }
    email { Faker::Internet.email }
    telefone { "41123456789" }
  end
end
