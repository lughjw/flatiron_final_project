class SessionsController < ApplicationController
    before_action :set_current_user

    def create
        acct = SpotifyAccount.find_by(access_token: params["spotify_token"])
        
        if acct
            puts "Creating session for #{acct.id}"
            user = acct.user
            session[:user_id] = user.id
            render json: {
                status: :created,
                logged_in: true,
                user: user
            }
        else
            render json: { status: 401 }
        end
    end

    def logged_in
        puts "logged_in_params"
        puts params
        if @current_user
            render json: {
                logged_in: true,
                user: @current_user
            }
        else
            render json: {
                logged_in: false
            }
        end
    end

    def logout
        reset_session
        render json: { status: 200, logged_out: true }
    end

    # private
    # def set_current_user
    #     puts "setting current user"
    #     if session[:user_id]
    #         @current_user = User.find(session[:user_id])
    #     end
    # end
end