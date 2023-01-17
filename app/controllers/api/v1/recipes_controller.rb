class Api::V1::RecipesController < ApplicationController 
  def index
    country = params[:country]
    recipe = RecipeFacade.recipe_info(country)
    render json: RecipeSerializer.new(recipe)
  end
end 