require 'rails_helper'

RSpec.describe Feature, type: :model do
  describe "associations" do
    it { should have_many(:item_features) }
    it { should have_many(:items) }
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:value) }
  end

  describe "#to_s" do
    context "returns the model as a string" do
      let(:feature) { create(:feature) }

      it { expect(feature.to_s).to eq("Title - Value") }
    end
  end
end
