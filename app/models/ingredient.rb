class Ingredient < ApplicationRecord
    validates :name, presence: true, length: {minimum: 3, maximum: 25}
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients
    default_scope -> { order(name: :asc)}
end
