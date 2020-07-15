require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "associations" do
    it { should have_many(:items) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
  end

  describe "#title_and_description" do
    context "returns a string of the category" do
      let(:category) { create(:category) }

      it { expect(category.title_and_description).to eq (
        'Fruits - Foods contained within the fruits food group.'
      )}
    end
  end
end
