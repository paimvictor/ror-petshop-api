require 'rails_helper'

RSpec.describe Cliente, type: :model do
  describe "validations" do
    it { should validate_presence_of(:nome) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:telefone) }
  end

  describe "associations" do
    it { should have_many(:pets) }
  end

  describe "validates email" do
    it "should be valid" do
      cliente = Cliente.new(nome: "Joao", email: "joao@email.com", telefone: "11999999999")
      expect(cliente.valid?).to be true
    end
    it "should be invalid" do
      cliente = Cliente.new(nome: "Joao", email: "joaoemail.com", telefone: "11999999999")
      expect(cliente.valid?).to be false
    end
  end

  describe "validates telefone" do
    it "should be valid" do
      cliente = Cliente.new(nome: "Joao", email: "joao@email.com", telefone: "11999999999")
      expect(cliente.valid?).to be true
    end
    it "should be invalid" do
      cliente = Cliente.new(nome: "Joao", email: "joao@email.com", telefone: "123456789")
      expect(cliente.valid?).to be false
    end
  end
end