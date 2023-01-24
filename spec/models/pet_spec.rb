require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:species) }
    it { should validate_presence_of(:breed) }
  end

  describe "associations" do
    it { should belong_to(:client) }
  end

end