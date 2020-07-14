# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

user = User.create!(email: 'alexander.b.dewhirst@gmail.com', password: 'testtest', password_confirmation: 'testtest')

feature_size_large = Feature.create!(user_id: user.id, title: "size", value: "large")
feature_size_small = Feature.create!(user_id: user.id, title: 'size', value: "small")
feature_color_red = Feature.create!(user_id: user.id, title: 'color', value: 'red')

category_fruits = Category.create!(title: 'fruits', description: 'Foods contained within the fruits food group.')
category_vegetables = Category.create!(title: 'vegetables', description: 'Foods contained within the vegetables food group.')

item_banana = Item.create!(category_id: category_fruits.id, user_id: user.id, name: 'banana', amount: 2, price: 250)
item_apple = Item.create!(category_id: category_fruits.id, user_id: user.id, name: 'apple', amount: 1, price: 99)
item_cucumber = Item.create(category_id: category_vegetables.id, user_id: user.id, name: 'cucumber', amount: 5, price: 80)

item_feature_banana_large = ItemFeature.create!(item_id: item_banana.id, feature_id: feature_size_large.id)
item_feature_apple_small = ItemFeature.create!(item_id: item_apple.id, feature_id: feature_size_small.id)
item_feature_apple_red = ItemFeature.create!(item_id: item_apple.id, feature_id: feature_color_red.id)

