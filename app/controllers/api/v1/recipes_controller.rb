class Api::V1::RecipesController < ApplicationController 
  def index
    country = params[:country]
    country = CountriesService.get_list.sample[:name] if country == ""
    recipe = RecipeFacade.recipe_info(country)
    render json: RecipeSerializer.new(recipe)
  end
end 