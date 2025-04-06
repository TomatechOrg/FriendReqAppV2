json.extract! friendship, :id, :primary_friend_id, :secondary_friend_id, :created_at, :updated_at
json.url friendship_url(friendship, format: :json)
