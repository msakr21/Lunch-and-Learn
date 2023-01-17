class LearningResourcesService 
  def self.get_videos(country)
      response = conn_video.get("/v3/search?part=snippet&maxResults=20&q=#{country}&type=video&channelId=UCluQ5yInbeAkkeCndNnUhpw&fields=items(id,snippet(title))&maxResults=1") 
      JSON.parse(response.body,symbolize_names: true)
  end 

  def self.conn_video
      Faraday.new("https://youtube.googleapis.com/youtube")
      f.params['key'] = ENV['GOOGLE_API-KEY']
  end 

  def self.get_images(country)
    response = conn_images.get("/v1/search?query=#{country}&per_page=10") 
    JSON.parse(response.body,symbolize_names: true)
  end 

  def self.conn_images
      Faraday.new("https://api.pexels.com")
      f.headers['Authorization'] = ENV['NOT_UNSPLASH']
  end 
end