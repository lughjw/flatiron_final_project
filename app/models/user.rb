require 'rest_client'

class User < ApplicationRecord
    has_many :playlists

    def access_token_expired?
        # check if user's token will expire within 5 minutes
        self.spotify_token_expire_time == nil || Time.now > (self.spotify_token_expire_time - 5*60)
    end

    def refresh_access_token
        if access_token_expired?
            body = {
                grant_type: 'refresh_token',
                access_token: self.spotify_access_token,
                refresh_token: self.spotify_refresh_token,
                client_id: Rails.application.credentials[:spotify][:client_id],
                client_secret: Rails.application.credentials[:spotify][:client_secret]
            }
            auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
            auth_params = JSON.parse(auth_response)

            puts "user#refresh_access_token auth_params => #{auth_params}"

            self.update(spotify_access_token: auth_params["access_token"], 
                spotify_refresh_token: auth_params["refresh_token"], 
                spotify_token_expire_time: Time.now + auth_params["expires_in"]
            )
        else
            puts "Current Token Has Not Expired"
        end
    end
end
