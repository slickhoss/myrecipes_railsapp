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

    def require_admin
        if !is_logged_in
            flash[:warning] = 'Please login as admin to continue'
            redirect_to login_path
        end
        if current_chef.try(:admin)
            flash[:danger] = 'Permission Denied'
            redirect_to ingredients_path
        end
    end
    
end
