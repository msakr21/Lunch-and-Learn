class LearningResourceFacade
  def self.resource_list(country)
    learning_resource_video_data = LearningResourcesService.get_video(country)
    learning_resource_images_data = LearningResourcesService.get_images(country)
    LearningResource.new(learning_resource_video_data, learning_resource_images_data, country)
  end 
end