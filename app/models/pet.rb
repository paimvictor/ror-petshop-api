class Pet < ApplicationRecord
  belongs_to :client
  has_many :services

  validates :name, presence: true
  validates :breed, presence: true
  validates :species, presence: true
end
