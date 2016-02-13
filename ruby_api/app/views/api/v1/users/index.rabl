collection @users
attributes :id, :username

node(:edit_url) { |users| edit_user_url(users) }
