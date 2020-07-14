FactoryBot.define do
    factory :item do
        name { "Banana" }
        amount { 2 }
        price { 225 }
        user { create :user }
        category { create :category }
    end
end