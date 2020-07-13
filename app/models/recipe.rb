class Recipe < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true, length: {minimum: 5, maximum: 750}
    
    belongs_to :user
    validates :user_id, presence: true
    default_scope -> { order(updated_at: :desc) }
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    has_many :comments, dependent: :destroy
end