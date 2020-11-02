require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    load_csv
  end

  def load_csv
    CSV.foreach(@csv_file) do |row|
      @recipes << Recipe.new(
        title: row[0],
        ingredients: row[1],
        rating: row[2],
        prep_time: row[3],
        read: row[4]
      )
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save
  end

  def mark_as_done(recipe)
    recipe.mark_as_done!
    save
  end

  def save
    CSV.open(@csv_file, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.title, recipe.ingredients, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
