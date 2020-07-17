class RecipeIngredientsController < ApplicationController

    def new
        @recipeingredient = RecipeIngredient.new
    end

    def create
        @recipeingredient = RecipeIngredient.new(recipe_ingredient_params)
        @recipeingredient.user = current_user
        if @recipeingredient.save
          flash[:success] = "Recipe was created successfully!"
          redirect_to new_recipe_recipe_ingredient_path(@recipeingredient)
        else
          render 'new'
        end
    end

    def show
        @recipeingredient = RecipeIngredient.new
    end
end

private

def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:quantity, :recipe_id, :ingredient_id)
end