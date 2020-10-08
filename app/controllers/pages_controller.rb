class PagesController < ApplicationController
    def home
        redirect_to recipes_path if is_logged_in
        @recipes = Recipe.all.limit(3)
    end
end
