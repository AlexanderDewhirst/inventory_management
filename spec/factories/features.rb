FactoryBot.define do
    factory :feature do
        title { 'title' }
        value { 'value' }
        user { create :user }
    end
    factory :color_yellow do
        title { "color" }
        value { "yellow" }
        user { create :user }
    end

    factory :color_red do
        title { "color" }
        value { "red" }
        user { create :user }
    end

    factory :size_small do
        title { "size" }
        value { "small" }
        user { create :user }
    end

    factory :size_large do
        title { "size" }
        value { "large" }
        user { create :user }
    end
end