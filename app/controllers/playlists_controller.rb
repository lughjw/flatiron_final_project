class PlaylistsController < ApplicationController
    require 'rest_client'

    skip_before_action :verify_authenticity_token

    def index
        #get currently logged in user
        # puts "Get first user #{User.first}"

        #TODO: make this use the @current_user from sessions rather than the first user
        current_user = SpotifyAccount.first
        if(current_user)
            # Make a fetch request
            
            if current_user.access_token_expired?
                current_user.refresh_access_token
            end
            
            header = {
                Authorization: "Bearer #{current_user.access_token}"
            }

            playlist_response = RestClient.get("https://api.spotify.com/v1/users/#{current_user.spotify_id}/playlists", header)
            playlist_params = JSON.parse(playlist_response)

            # puts playlist_params

            render json: playlist_params
        # else
        #     redirect_to login_path
        end
    end

    def show
        playlist = Playlist.find_by(spotify_id: params[:id])
        if playlist
            render json: playlist
        else
            current_user = User.first
            if current_user.access_token_expired?
                current_user.refresh_access_token
            end
            
            header = {
                Authorization: "Bearer #{current_user.spotify_access_token}"
            }

            result = RestClient.get("https://api.spotify.com/v1/playlists/#{params[:id]}", header)
            render json: result
        end
    end

    def create
        # render json: params
        current_user = User.first.spotify_account

        ans = current_user.create_playlist_on_spotify(params[:name])

        # puts "\nAnswer from create_playlist_on_spotify"
        # puts ans

        render json: ans
    end

    #fetches the songs for the playlist
    def songs
        current_user = User.first.spotify_account

        header = {
            Authorization: "Bearer #{current_user.access_token}"
        }

        tracks_response = RestClient.get("https://api.spotify.com/v1/playlists/#{params[:id]}/tracks", header)

        render json: tracks_response
    end

    def delete_song
        puts "deleting song #{params[:track_id]} from playlist #{params[:playlist_id]}"
        current_user = User.first.spotify_account

        info = {
            method: :delete,
            url: "https://api.spotify.com/v1/playlists/#{params[:playlist_id]}/tracks",
            payload: {
                tracks:[
                    { "uri" => "spotify:track:#{ params[:track_id] }"}
                ]
            }.to_json,
            headers: {
                Authorization: "Bearer #{current_user.access_token}",
                "Content-Type": "application/json",
            }
        }

        begin
            tracks_response = RestClient::Request.execute( info )
        rescue RestClient::BadRequest => br
            puts "ERRROR: REST_CLIENT BAD REQUEST"
            tracks_response = JSON.parse(br.response)
        end
        
        render json: tracks_response
    end

    def destroy
        #check if current user is owner of the playlist before destroying
        # playlist = Playlist.find_by(spotify_id: params[:id])

        # playlist.destroy

        # unfollow playlist on spotify. There is no support for deleting a playlist.

        # puts "starting delete of playlist"
        # puts params

        current_user = User.first.spotify_account

        ans = current_user.delete_playlist_on_spotify(params[:id])

        render json: ans

    end

    def update
        playlist = Playlist.find_by(spotify_id: params[:id])

        playlist.update(update_params)
    end

    private
    def update_params
        params
    end
end
