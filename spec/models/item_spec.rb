require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "associations" do
    it { should have_many(:item_features) }
    it { should have_many(:features) }
    it { should belong_to(:category) }
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:amount).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:price).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe "#list_of_features" do
    context "returns a list of associated features as a string" do
      let(:item) { create(:item) }
      let(:feature1) { create(:feature) }
      let(:feature2) { create(:feature) }
      before do
        ItemFeature.create!(item_id: item.id, feature_id: feature1.id)
        ItemFeature.create!(item_id: item.id, feature_id: feature2.id)
      end

      it { 
        expect(item.list_of_features).to eq(
          "Title: Value, Title: Value"
        ) 
      }
    end
  end

  describe "#duplicate" do
    context "duplicates the item" do
      let(:item) { create(:item) }
      
      it { expect(item.duplicate).to have_attributes(
        name: "banana",
        amount: 2,
        price: 225
      ) }
    end
  end

  describe "#selected_features" do
    context "collects the item features" do
      let(:item) { create(:item) }
      let(:feature1) { create(:feature) }
      let(:feature2) { create(:feature) }
      before do
        ItemFeature.create!(item_id: item.id, feature_id: feature1.id)
        ItemFeature.create!(item_id: item.id, feature_id: feature2.id)
      end

      it { expect(item.selected_features).to be_present }
      # TODO: test the query result
    end
  end

  describe "#price_in_dollars" do
    context "returns the price as a float using dollars" do
      let(:item) { create(:item) }
      it { expect(item.price_in_dollars).to eq(2.25) }
    end
  end
end
