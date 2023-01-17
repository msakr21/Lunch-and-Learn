class Api::V1::FavoritesController < ApplicationController 
  def create
    if user = User.find_by(api_key: params[:api_key])
      user.favorites << Favorite.create(recipe_title: params[:recipe_title], recipe_link: params[:recipe_link], country: params[:country])
      render json: { "success": "Favorite added successfully"}, status: 201
    else
      render json: {error: "The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible.", code: 404, status: "Not Found"} , status: 404
    end
  end

  def index
    if user = User.find_by(api_key: params[:api_key])
      render json: FavoriteSerializer.new(user.favorites)
    else
      render json: {error: "The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible.", code: 404, status: "Not Found"} , status: 404
    end
  end

  def delete
  end
end