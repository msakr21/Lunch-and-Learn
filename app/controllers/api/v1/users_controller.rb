class Api::V1::UsersController < ApplicationController 
  def create
    api_key = SecureRandom.urlsafe_base64
    user = User.new(name: params[:name], email: params[:email], api_key: api_key)
    if user.save
      render json: UserSerializer.new(user)
    else
      render json: {Error: "This email is already in use. Please use another one."}
    end
  end
end 