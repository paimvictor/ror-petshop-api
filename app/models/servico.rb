class Servico < ApplicationRecord
  belongs_to :pet

  validates :titulo, presence: true
  validates :preco, presence: true, numericality: { greater_than: 0 }
  validates :data_agendamento, presence: true
end
