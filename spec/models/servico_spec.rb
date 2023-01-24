RSpec.describe Service, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:scheduled_date) }
  end

  describe "associations" do
    it { should belong_to(:pet) }
  end

  describe "validates price" do
    let(:pet) { create(:pet) }
    let(:valid_service) { build_stubbed(:service, pet: pet) }
    let(:invalid_service) { build_stubbed(:service, price: -50, pet: pet) }

    it "is valid with valid attributes" do
      expect(valid_service).to be_valid
    end

    it "is invalid with invalid attributes" do
      expect(invalid_service).to be_invalid
    end
  end
end
