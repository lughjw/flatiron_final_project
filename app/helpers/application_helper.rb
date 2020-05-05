module ApplicationHelper
    SPOTIFY_CLIENT_ID = Rails.application.credentials[:spotify][:client_id]
    SPOTIFY_CLIENT_SECRET = Rails.application.credentials[:spotify][:client_secret]
end
