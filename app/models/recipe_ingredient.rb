class RecipeIngredient < ApplicationRecord
    belongs_to :ingredient
    belongs_to :recipe
    accepts_nested_attributes_for :recipe
    
    attr_accessor :quantity, :recipe_attributes

    validates_uniqueness_of :ingredient_id, scope: :recipe_id
    validates :quantity, presence: true
end