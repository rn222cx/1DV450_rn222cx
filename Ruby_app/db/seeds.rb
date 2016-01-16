#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(:username => "roy", :email => "test@gmail.com", :password => "pass", :api_key => "543" ) 

story1 = Story.create(:title => "Min historia", :description => "föddes i växjö", :longitude => 27.73, :latitude => 14.65)
story2 = Story.create(:title => "Historian om växjö", :description => "Där vägarna möts", :longitude => 23.43, :latitude => 54.45)

tag1 = TagType.create(:era => "Viking Age")
tag2 = TagType.create(:era => "Bronze Age")
tag3 = TagType.create(:era => "Iron Age")

tags1 = Tag.create()

user1.stories << story1
user1.stories << story2

story1.tags << tags1
tag1.tags << tags1