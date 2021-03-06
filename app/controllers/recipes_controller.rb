class RecipesController < ApplicationController
    
    before_action :instance_of_recipe, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @recipes = Recipe.paginate(page: params[:page], per_page: 5)
            if params[:search]
                @recipes = Recipe.search(params[:search])
                #@recipes = Recipe.where('name LIKE ?', "%#{params[:search]}%")
            else 
                @recipes = Recipe.all
            end    
    end

    def show
        @comments = Comment.new
        @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.user = current_user
        if @recipe.save
          flash[:success] = "Recipe was created successfully!"
          redirect_to recipe_path(@recipe)
        else
          render 'new'
        end
    end
                
    def edit
    end

    def update
        if @recipe.update(recipe_params)
            flash[:success] = "Recipe updated!"
            redirect_to recipe_path(@recipe)
        else
            render 'edit'
        end
    end

    def destroy
        Recipe.find(params[:id]).destroy
        flash[:success] = "Recipe deleted!"
        redirect_to recipes_path
    end

private

    def instance_of_recipe
        @recipe = Recipe.find(params[:id])    
    end

    def recipe_params
        params.require(:recipe).permit(:name, :description, ingredient_ids: [])
    end
    
    def require_same_user
        if current_user != @recipe.user and !current_user.admin?
            flash[:danger] = " You can only edit or delete your own recipes"
            redirect_to recipes_path
        end
    end
end
