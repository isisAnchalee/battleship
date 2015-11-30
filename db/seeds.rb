# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  meow = User.where(email: 'meow@meow.meow').first_or_create!(password: 'hellosir')
  isis = User.where(email: 'isis@isis.isis' ).first_or_create!(password: 'muppets')
  first_game = Game.where(first_player_id: meow.id, second_player_id: isis.id, state: 'setup')

  10.times do |i|
    User.where(email: Faker::Internet.email).first_or_create!(password: Faker::Commerce.color)
  end
  