class Pet < ApplicationRecord
  belongs_to :cliente
  has_many :servicos

  validates :nome, presence: true
  validates :raca, presence: true
  validates :especie, presence: true
end
