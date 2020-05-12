class ApplicationController < ActionController::Base
    before_action :set_current_user

    private
    def set_current_user
        puts "set_current_user_params"
        puts params
        puts "setting current user #{session[:user_id]}"
        @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
        if session[:user_id]
            @current_user = User.find(session[:user_id])
        end
    end
end
