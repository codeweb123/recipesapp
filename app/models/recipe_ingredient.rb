class RecipeIngredient < ApplicationRecord
    belongs_to :ingredient
    belongs_to :recipe
    #validates :recipeingredients, presence: true
end