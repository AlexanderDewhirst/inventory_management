FactoryBot.define do
    factory :feature do
        title { 'title' }
        value { 'value' }
        user { create :user }
    end
end