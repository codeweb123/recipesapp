class Ingredient < ApplicationRecord
    attr_accessor :quantity
    validates :name, presence: true, length: { minumum: 3, maximum: 25 }
    validates_uniqueness_of :name
    has_many :recipe_ingredients 
    has_many :recipes, through: :recipe_ingredients
    scope :with_liquid, -> { where("liquid > 0") } #custom queries, lambda implements the query(Ingredient.with_liquid)
end