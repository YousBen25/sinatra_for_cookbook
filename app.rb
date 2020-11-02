require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require 'open-uri'
require 'nokogiri'
require_relative 'cookbook'
require_relative "recipe"
require_relative 'scrap_all_recipes_service'

csv_file = File.join(__dir__, 'recipes.csv')
COOKBOOK = Cookbook.new(csv_file)

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  erb :index
end

get '/list' do
  # Who is the cookbook
  # get all the recipes
  # @cookbook.all
  @recipes = COOKBOOK.all
  erb :list
end

get '/list/:id' do
  # Who is the cookbook
  puts params[:id]
  # get all the recipes
  # @cookbook.all
  @recipes = COOKBOOK.all
  erb :list
end

get '/new'  do
  erb :new
end

post '/recipes' do
  new_recipe = Recipe.new(params)
  COOKBOOK.add_recipe(new_recipe)
  redirect '/list'
end

get '/mark'  do
  @recipes = COOKBOOK.all
  erb :mark
end

patch '/mark_as_done' do
  recipe = COOKBOOK.all[params[:index].to_i - 1]
  @mark_as_done = COOKBOOK.mark_as_done(recipe)
  redirect '/mark'
end

get '/import' do
  @search = []
  erb :import
end

get '/import_recipes' do
  @search = ScrapAllRecipesService.new(params[:ingredients]).call
  erb :import
end

get '/destroy/:index' do
  COOKBOOK.remove_recipe(params[:index].to_i)
  redirect '/list'
end

get '/about' do
  erb :about
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end

get '/layout' do
  erb :layout
end
