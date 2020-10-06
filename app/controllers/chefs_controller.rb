class ChefsController < ApplicationController
    def show
        @chef = Chef.find(params[:id])
    end
    
    def new
        @chef = Chef.new
    end

    def create
        @chef = Chef.new(chef_params)
        if @chef.save
            flash[:success] = "Welcome #{@chef.name} to MYRECIPES App"
            redirect_to chef_path(@chef)
        else
            render 'new'
        end
    end

    def edit
        @chef = Chef.find(params[:id])

    end

    def update
        @chef = Chef.find(params[:id])
        if @chef.update(chef_params)
            flash[:success] = 'Chef profile was updated'
            redirect_to @chef
        else
            render 'edit'
        end
    end

    def destroy 
        @chef = Chef.find(params[:id])
        @chef.recipes.destroy
        @chef.destroy
        flash[:success] = 'Profile was successfully deleted'
        redirect_to recipes_path
    end

    private
        def chef_params
            params.require(:chef).permit(:name, :email, :password, :password_confirmation)
        end
end
