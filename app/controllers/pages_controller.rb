class PagesController < ApplicationController
    def home
        redirect_to recipes_path if is_logged_in
    end
end
