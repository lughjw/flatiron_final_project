require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
    # For more information on Spotify scopes https://developer.spotify.com/documentation/general/guides/scopes/
    scope = [
        'user-read-email',
        'playlist-read-collaborative',
        'playlist-read-private',
        'playlist-modify-private',
        'playlist-modify-public',
    ].join(' ')

    provider :spotify, "Client ID", "Client Secret", scope: scope
end