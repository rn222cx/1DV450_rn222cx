collection @story

attributes :id, :title, :description, :longitude, :latitude, :created_at

#unless locals[:hide_username]

node(:edit_url) { |stories| edit_story_url(stories) }

child(:user) { attributes :username, :admin }


child :tags do
  attribute :created_at, :name
end