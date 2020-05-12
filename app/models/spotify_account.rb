require 'rest_client'
class SpotifyAccount < ApplicationRecord
  belongs_to :user

  def access_token_expired?
    # check if access token will expire within 5 minutes
    Time.now > (self.token_expiration_time - 300)
  end

  def refresh_access_token
    if access_token_expired?
      refresh_access_token!
      "Access token refreshed"
    else
      "Access token still valid"
    end
  end

  def refresh_access_token!
    client_id = Rails.application.credentials[:spotify][:client_id]
    client_secret = Rails.application.credentials[:spotify][:client_secret]
    client_id_encode = Base64.strict_encode64("#{client_id}:#{client_secret}")
    
    headers = {
      Authorization: "Basic #{client_id_encode}"
    }

    body = {
      grant_type: "refresh_token",
      refresh_token: self.refresh_token
    }
    auth_response = RestClient.post('https://accounts.spotify.com/api/token', body, headers)
    auth_params = JSON.parse(auth_response)
    self.update(
      access_token: auth_params["access_token"], 
      token_expiration_time: Time.now + auth_params["expires_in"]
    )
  end
end
