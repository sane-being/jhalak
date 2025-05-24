json.extract! follow_request, :id, :accepted, :user_id, :follower_id, :created_at, :updated_at
json.url follow_request_url(follow_request, format: :json)
