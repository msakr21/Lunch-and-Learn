class Api::V1::FavoritesController < ApplicationController 
  def create
    if User.find_by(api_key: params[:api_key])
      Favorite.create(favorite_params)
      render json: { "success": "Favorite added successfully"}, status: 201
    else
      render json: {error: "The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible.", code: 404, status: "Not Found"} , status: 404
    end
  end

  def get
  end

  def delete
  end

  private

  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
end