class AuthController < ApplicationController
  def spotify_request
    url = "https://accounts.spotify.com/authorize"
    query_params = {
      client_id: Rails.application.credentials[:spotify][:client_id],
      response_type: 'code',
      redirect_uri: 'http://localhost:4000/user',
      scope: [
        'user-read-email',
        'playlist-read-collaborative',
        'playlist-read-private',
        'playlist-modify-private',
        'playlist-modify-public'
    ].join(' '),
     show_dialog: true
    }

    puts "\nredirecting to spotify authorization\n"
    redirect_to "#{url}?#{query_params.to_query}"
  end

  # def show
  #   puts params
  # end
end
