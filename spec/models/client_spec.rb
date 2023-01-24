require 'rails_helper'

RSpec.describe Client, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
    it { should allow_value("joao@email.com").for(:email) }
    it { should_not allow_value("joaoemail.com").for(:email) }
    it { should allow_value("11999999999").for(:phone) }
    it { should_not allow_value("123456789").for(:phone) }
  end

  describe "associations" do
    it { should have_many(:pets) }
  end
end
