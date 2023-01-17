class LearningResource
  attr_reader :country, :video, :images

  def initialize(video_info = {}, images_data = [], country)
      @country = country
      @video = {"title" => video_info[:items].first[:snippet][:title], "youtube_video_id" => video_info[:items].first[:id][:videoId]}
      @images = []
      add_image_info(images_data)
  end 

  def add_image_info(images_data)
    images_data[:photos].each do |image_info|
      @images << {"alt_tag" => image_info[:alt], "url" => image_info[:url], "photographer" => image_info[:photographer], "photographer_pexel_page" => image_info[:photographer_url]}
    end
  end
end 