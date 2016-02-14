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

domain1 = Domain.create(:domain_name => "smp.se", :description => "My news site", :authentication_token => "RandomString")

user1.domains << domain1

user1.stories << story1
user1.stories << story2

# create and add a tag
tag1 = Tag.create(:name => "roligt")
tagging1 = StoryTag.create
story1.story_tags << tagging1
tag1.story_tags << tagging1


# create some fake users
50.times do |n|
  username  = Faker::Name.first_name
  email = "example-#{n+1}@rails.org"
  password = "password"
  User.create!(username: username,
               email: email,
               password:              password,
               password_confirmation: password)
end

# create some fake stories
users = User.order(:created_at).take(20)
5.times do
  lat = Faker::Number.decimal(2)
  content = Faker::Lorem.sentence(5)
  title  = Faker::Lorem.word
  lon = Faker::Number.decimal(2)
  users.each { |user| user.stories.create!(title: title, description: content, longitude: lon, latitude: lat) }
end


# create some fake tags
15.times do |n|
  tag = Tag.create(:name => "Tag-#{n+1}")
  tagging = StoryTag.create
  story = Story.find(n+1)
  story.story_tags << tagging
  tag.story_tags << tagging
end
