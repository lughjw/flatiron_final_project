class AuthController < ApplicationController
  def spotify_request
    url = "https://accounts.spotify.com/authorize"
    query_params = {
      client_id: helpers.SPOTIFY_CLIENT_ID,
      response_type: 'code',
      redirect_uri: 'http://localhost:4000/user',
      scope = [
        'user-read-email',
        'playlist-read-collaborative',
        'playlist-read-private',
        'playlist-modify-private',
        'playlist-modify-public'
    ].join('%20')
     show_dialog: true
    }
    redirect_to "#{url}?#{query_params.to_query}"
  end

  def show
    puts params
  end
end
