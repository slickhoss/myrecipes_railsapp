class IngredientsController < ApplicationController
    before_action :require_admin, except: [:show, :index]
    def index
        @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
    end

    def show
        @ingredient = Ingredient.find(params[:id])
        @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
    end

    def new
        @ingredient = Ingredient.new
    end

    def create
        @ingredient = Ingredient.new(ingredient_params)
        if @ingredient.save
            flash[:success] = 'Ingredient successfully added'
            redirect_to ingredients_path
        else
            render 'new'
        end
    end
    
    def edit
        @ingredient = Ingredient.find(params[:id])
    end

    def update
        @ingredient = Ingredient.find(params[:id])
        if @ingredient.update(ingredient_params)
            flash[:success] = 'Ingredient updated'
            redirect_to ingredients_path
        else
            render 'edit'
        end
    end

    def destroy
        @ingredient = Ingredient.find(params[:id])
        @ingredient.destroy
    end

    private
        def ingredient_params
            params.require(:ingredient).permit(:name)
        end
end
