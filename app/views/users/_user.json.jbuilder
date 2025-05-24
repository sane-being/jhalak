json.extract! user, :id, :bio, :website, :username, :created_at, :updated_at
json.url user_url(user, format: :json)
