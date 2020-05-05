Rails.application.routes.draw do
  get 'auth/spotify_request'
  get 'auth/show'
  get 'users/spotify'
  get 'users/show'
  get 'users/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show,:create]
  resources :playlists, only: [:show,:create]

  #TODO: Add SMS endpoint for searching for a song
  #TODO: Add endpoints for playlists

  #
  get '/login', to: "auth#spotify_request"

  # callback from authentication with spotify
  get '/auth/spotify/callback', to: 'users#spotify'
end
