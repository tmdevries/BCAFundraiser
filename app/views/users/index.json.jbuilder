json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :password_digest, :auth_token, :email, :admin, :notify_by_email, :notify_by_text, :phone_number
  json.url user_url(user, format: :json)
end
