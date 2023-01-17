class Recipe 
  attr_reader :title, :url, :country, :image

  def initialize(recipe_info, country)
      @title = recipe_info[:recipe][:label]
      @url = recipe_info[:recipe][:url]
      @country = country.capitalize
      @image = recipe_info[:recipe][:image]
  end 
end 