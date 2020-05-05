require 'rest_client'

class User < ApplicationRecord
    has_many :playlists

    def access_token_expired?
        # check if user's token is older than 55 minutes
        (Time.now - self.token_start) > 3300
    end

    def refresh_access_token
        if access_token_expired?
            body = {
                grant_type: 'refresh_token',
                refresh_token: self.spotify_refresh_token,
                client_id: Rails.application.credentials[:spotify][:client_id],
                client_secret: Rails.application.credentials[:spotify][:client_secret]
            }
            auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
            auth_params = JSON.parse(auth_response)

            self.update(spotify_access_token: auth_params["access_token"], spotify_token_start_time: Time.now)
        else
            puts "Current Token Has Not Expired"
        end
    end
end
