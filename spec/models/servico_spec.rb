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
    let(:pet) { create(:pet) }
    let(:valid_servico) { build_stubbed(:servico, pet: pet) }
    let(:invalid_servico) { build_stubbed(:servico, preco: -50, pet: pet) }

    it "is valid with valid attributes" do
      expect(valid_servico).to be_valid
    end

    it "is invalid with invalid attributes" do
      expect(invalid_servico).to be_invalid
    end
  end
end
