class Client < ApplicationRecord
    has_many :pets, dependent: :destroy

    validates :name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
    validates :phone, presence: true, length: { is: 11 }
end
