class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper_method :current_chef, :is_logged_in
    def current_chef
        @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
    end

    def is_logged_in
       !!current_chef
    end

    #checks if the user is logged in if not redirects to root
    def require_user
        if !is_logged_in
            flash[:danger] = 'You must be logged in to perform this action'
            redirect_to root_path
        end
    end

    
end
