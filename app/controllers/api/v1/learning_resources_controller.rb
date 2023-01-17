class Api::V1::LearningResourcesController < ApplicationController 
  def show
    country = params[:country]
    learning_resource = LearningResourceFacade.resource_list(country)
    render json: LearningResourceSerializer.new(learning_resource)
  end
end