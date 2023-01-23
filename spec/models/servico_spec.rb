require 'rails_helper'

RSpec.describe Servico, type: :model do
  describe "validations" do
    it { should validate_presence_of(:titulo) }
    it { should validate_presence_of(:preco) }
    it { should validate_presence_of(:data_agendamento) }
  end

  describe "associations" do
    it { should belong_to(:pet) }
  end

  describe "validates preco" do
    it "should be valid" do
      pet = Pet.create(nome: "Fido", especie: "dog", raca: "Golden Retriever")
      servico = Servico.new(titulo: "Banho", preco: 50, data_agendamento: DateTime.now, pet: pet)
      expect(servico.valid?).to be true
    end
    it "should be invalid" do
      pet = Pet.create(nome: "Fido", especie: "dog", raca: "Golden Retriever")
      servico = Servico.new(titulo: "Banho", preco: -50, data_agendamento: DateTime.now, pet: pet)
      expect(servico.valid?).to be false
    end
  end
end
