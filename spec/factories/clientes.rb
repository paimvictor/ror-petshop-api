FactoryBot.define do
  factory :cliente do
    nome { Faker::Name.name }
    email { Faker::Internet.email }
    telefone { Faker::PhoneNumber.phone_number }
  end
end
