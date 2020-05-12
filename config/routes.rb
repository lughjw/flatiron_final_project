Rails.application.routes.draw do
  resources :users
  # get '/login', to: "auth#spotify_request"
  get 'login', to: "spotify#login"
  get 'spotify/user', to: "spotify#user"
  get 'spotify/login_callback', to: "spotify#login_callback"
  get 'logged_in', to: "sessions#logged_in"
  get 'sessions/create', to: "sessions#create"
  # post 'users/create', to: "users#create"

  # get 'users/spotify'
  # get 'users/show'
  # get 'users/create'

  # delete '/playlists/:playlist_id/tracks/:track_id', to: "playlists#delete_song"
  # # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :users, only: [:show,:create]
  # resources :playlists, only: [:index,:show,:create,:destroy]

  #TODO: Add SMS endpoint for searching for a song

  # #
  # post '/playlists', to: "playlists#create"
  # get '/user', to: "users#create"
  # get '/logged_in', to: "sessions#logged_in"
  # get '/playlists', to: "playlists#index"
  # get '/playlists/:id/tracks', to: "playlists#songs"

  

  # get '/users/:id/playlists', to: "playlists#index"
  # get '/users/:user_id/playlists/:playlist_id', to: "playlists#show"
  # callback from authentication with spotify
  # get '/callback', to: 'users#spotify'
end
