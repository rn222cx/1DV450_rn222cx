collection @stories

extends "api/v1/stories/show"
#extends('api/v1/stories/index', :locals => { :hide_username => true })


if @stories.count == @limit
  node(:next_page){ stories_url(limit: @limit, offset: @limit + @offset) }
end

if @offset > 0
  node(:previous_page){ stories_url(limit: @limit, offset: @offset - @limit) }
end