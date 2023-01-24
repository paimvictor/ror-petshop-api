class Service < ApplicationRecord
  belongs_to :pet

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :scheduled_date, presence: true
end
