require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of(:nome) }
    it { should validate_presence_of(:especie) }
    it { should validate_presence_of(:raca) }
  end

  describe "associations" do
    it { should belong_to(:cliente) }
  end

end