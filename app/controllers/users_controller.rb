require 'rest_client'

class UsersController < ApplicationController
  def show
  end

  def create
    render json: params
    # Request refresh and access tokens
    # body = {
    #   grant_type: "authorization_code",
    #   code: params[:code],
    #   redirect_uri: 'http://localhost:4000/user',
    #   client_id: Rails.application.credentials[:spotify][:client_id],
    #   client_secret: Rails.application.credentials[:spotify][:client_secret]
    # }

    # auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
    # auth_params = JSON.parse(auth_response.body)
    
    # header = {
    #   Authorization: "Bearer #{auth_params["access_token"]}"
    # }

    # user_response = RestClient.get("https://api.spotify.com/v1/me", header)
    # user_params = JSON.parse(user_response.body)
    
    # # puts "users_controller auth_params => #{auth_params}"
    # #Create User 
    # @user = User.find_by(
    #   name: user_params["display_name"],
    #   spotify_id: user_params["id"],
    # )

    # if not @user
    #   @user = User.create(
    #     name: user_params["display_name"],
    #     spotify_id: user_params["id"],
    #   )
    # end

    # @user.update(
    #   spotify_access_token: auth_params["access_token"],
    #   spotify_refresh_token: auth_params["refresh_token"],
    #   spotify_token_expire_time: Time.now + auth_params["expires_in"]
    # )

    # # associate session with this user
    # session[:user_id] = @user.id

    # @user.save
      
    # # image = user_params["images"][0] ? user_params["images"][0]["url"] : nil
    # # country = user_params["country"] ? user_params["country"] : nil

    # #Update the user if they have image or country
    # # @user.update(image: image, country: country)

    # #Update the user access/refresh_tokens
    # if @user.access_token_expired?
    #   @user.refresh_access_token
    # else
    #   @user.update(
    #     spotify_access_token: auth_params["access_token"], 
    #     spotify_refresh_token: auth_params["refresh_token"],
    #     spotify_token_expire_time: Time.now + auth_params["expires_in"],
    #   )
    # end

    
    # # puts params
    # #Redirect to Front End app homepage
    # redirect_to "http://localhost:3000/playlists"
  end

end
