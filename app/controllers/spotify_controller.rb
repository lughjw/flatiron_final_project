require 'rest_client'

class SpotifyController < ApplicationController
    # before_action :check_token, except: [:login,:login_callback, :user_params]

    def login
        url = "#{ACCOUNTS_URL}/authorize"

        #TODO: add state key with randomly generated value to increase security
        # check state is the same in callback function to make sure nothing was tampered with.
        query_params = {
            show_dialog: true,
            client_id: Rails.application.credentials[:spotify][:client_id],
            response_type: 'code',
            redirect_uri: "http://localhost:4000/spotify/login_callback",
            scope: [
                'user-read-email',
                'playlist-read-collaborative',
                'playlist-read-private',
                'playlist-modify-private',
                'playlist-modify-public'
            ].join(' '),
        }
    
        puts "\nredirecting to spotify authorization\n"
        redirect_to "#{url}?#{query_params.to_query}"
    end

    # Return from the spotify login
    def login_callback
        # Check if spotify sent an auth token
        puts "login_callback"
        puts params
        if(params[:code])
            client_id = Rails.application.credentials[:spotify][:client_id]
            client_secret = Rails.application.credentials[:spotify][:client_secret]
            client_id_encode = Base64.strict_encode64("#{client_id}:#{client_secret}")
            
            headers = {
                Authorization: "Basic #{client_id_encode}"
            }

            # redirect uri must match the redirect uri used during the 
            # previous authentication call
            body = {
                grant_type: "authorization_code",
                code: params[:code],
                redirect_uri: "http://localhost:4000/spotify/login_callback",
            }

            # begin
            # trade auth code for refresh and access tokens
            token_request = RestClient.post("#{ACCOUNTS_URL}/api/token", body, headers)
            token_obj = JSON.parse(token_request)

            access_token = token_obj["access_token"]
            token_type = token_obj["token_type"]
            expires_in = token_obj["expires_in"]
            refresh_token = token_obj["refresh_token"]
            scope = token_obj["scope"]

            # Send a request for information on the user
            headers = {
                Authorization: "Bearer #{access_token}"
            }
            user_resp = RestClient.get("https://api.spotify.com/v1/me", headers)
            user_obj = JSON.parse(user_resp)

            # Create/find user with returned information
            user = User.find_by(email: user_obj["email"])
            if not user
                user = User.create(
                    email: user_obj["email"],
                )
            end

            acct = SpotifyAccount.find_by(email: user_obj["email"])
            if not acct
                acct = SpotifyAccount.create(
                    user: user,
                    email: user_obj["email"],
                    display_name: user_obj["display_name"],
                    spotify_id: user_obj["id"],
                    href: user_obj["href"],
                    access_token: access_token,
                    refresh_token: refresh_token,
                    token_expiration_time: Time.now + expires_in
                )
            else
                acct.update(
                    access_token: access_token,
                    refresh_token: refresh_token,
                    token_expiration_time: Time.now + expires_in
                )
            end

            resp = { spotify: acct, user: user }
            
            # puts "Setting session to #{user.id}"
            # session[:user_id] = user.id
            # puts "Session set to #{session[:user_id]}"
            # puts "session obj #{session}"

            # redirect_to "http://localhost:3000"
            redirect_to "http://localhost:3000?access_token=#{access_token}"
        #     rescue RestClient::BadRequest => br
        #         #User most likely declined
        #         resp = { message: br.message, response: br.response }
        #         redirect_to "http://localhost:3000?error=#{resp}"
        #     end
        else
            # send an error
            resp = {message: params[:error]}
            redirect_to "http://localhost:3000?error=#{resp}"
        end
    end

    def user
        render json: params
    end

    private
    ACCOUNTS_URL = "https://accounts.spotify.com"

    def user_params
        params.permit("email", "display_name", )
    end


end