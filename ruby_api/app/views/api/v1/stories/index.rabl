collection @stories

extends "api/v1/stories/show"
#extends('api/v1/stories/index', :locals => { :hide_username => true })

node(:show_story) { |stories| story_url(stories) }

if @stories.count(:all) == @limit
  node(:next_page){ stories_url(limit: @limit, offset: @limit + @offset) }
end

if @offset > 0
  node(:previous_page){ stories_url(limit: @limit, offset: @offset - @limit) }
end