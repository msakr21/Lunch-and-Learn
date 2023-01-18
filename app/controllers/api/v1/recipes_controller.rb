class Api::V1::RecipesController < ApplicationController 
  def index
    country = params[:country]
    country = CountriesService.get_list.sample[:name] unless country 
    recipe = RecipeFacade.recipe_info(country)
    # binding.pry
    if recipe.nil? 
      render json: {"data": []}
    else
      render json: RecipeSerializer.new(recipe)
    end
  end
end 