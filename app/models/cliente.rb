class Cliente < ApplicationRecord
    has_many :pets, dependent: :destroy

    validates :nome, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
    validates :telefone, presence: true, length: { is: 11 }
end
