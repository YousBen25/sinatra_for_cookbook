# Recipe model

class Recipe
  attr_accessor :title, :ingredients, :rating, :prep_time

  def initialize(attributes = {})
    @title = attributes[:title]
    @ingredients = attributes[:ingredients]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    @done = attributes[:read] == "true"
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
