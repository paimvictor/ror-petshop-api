class Servico < ApplicationRecord
  belongs_to :pet

  validates :titulo, presence: true
  validates :preco, presence: true
  validates :data_agendamento, presence: true
end
