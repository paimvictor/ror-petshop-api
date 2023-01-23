class Pet < ApplicationRecord
  belongs_to :cliente

  validates :nome, presence: true
  validates :raca, presence: true
  validates :especie, presence: true
end
