require 'open-uri'
require 'nokogiri'
require_relative 'recipe'

class ScrapAllRecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # TODO: return a list of `Recipes` built from scraping the web.
    url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@keyword}"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.recipe-card')[0...5].map do |card|
      title = card.search('.recipe-card__title')[0].text.strip
      ingredients = card.search('.recipe-card__description')[0].text.strip
      rating = card.search('.recipe-card__rating__value')[0].text.strip
      prep_time = card.search('.recipe-card__duration__value')[0].text.strip
      Recipe.new(title: title, ingredients: ingredients, rating: rating, prep_time: prep_time)
    end
  end
end
