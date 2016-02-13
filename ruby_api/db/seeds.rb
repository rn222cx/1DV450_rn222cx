#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(:username => "Admin", :email => "admin@admin.com", :password => "1234", admin: true )
user2 = User.create(:username => "JohnDoe", :email => "johndoe@hotmail.com", :password => "password" )

story1 = Story.create(:title => "Mordet på Palme", :description => "Skjuten i Stockholm, mördare okänd", :longitude => 27.73, :latitude => 14.65)
story2 = Story.create(:title => "Historian om växjö", :description => "Sloganen där vägarna möts har bytts ut mot europas grönaste stad", :longitude => 23.43, :latitude => 54.45)

domain1 = Domain.create(:domain_name => "smp.se", :description => "My news site", :authentication_token => "QHaND7lr36M/lM/kaIpghaZO0PkFwla+NU37oB4DMg0Ph7qvtjmA0xGZ+jAM4ENSXC1A/1iQMqs4Z8DTcc9Kbw==")

user1.domains << domain1

user1.stories << story1
user1.stories << story2

# create and add a tag
tag1 = Tag.create(:name => "roligt")
tagging1 = StoryTag.create
story1.story_tags << tagging1
tag1.story_tags << tagging1


# create some fake users
5.times do |n|
  username  = Faker::Name.name
  email = "example-#{n+1}@rails.org"
  password = "password"
  User.create!(username: username,
               email: email,
               password:              password,
               password_confirmation: password)
end

# create some fake stories
# users = User.order(:created_at).take(6)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   title  = Faker::Name.name
#   users.each { |user| user.stories.create!(title: title, description: content) }
# end