FactoryBot.define do
    factory :user do
        sequence(:email) { |n| "test-#{n}@test.com" }
        password { 'testtest' }
        password_confirmation { 'testtest' }
    end
end