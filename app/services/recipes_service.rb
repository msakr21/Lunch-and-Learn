class RecipesService 
  def self.get_recipe(country)
      response = conn.get("/api/recipes/v2") do |req|
        req.options[:params_encoder] = Faraday::FlatParamsEncoder #added to prevent field in query from line 7 to have %5B%5D
        req.params['type'] = 'public'
        req.params['q'] = "#{country}"
        req.params['field'] = ['label', 'image', 'url']
      end
      JSON.parse(response.body,symbolize_names: true)
  end 

  def self.conn 
    Faraday.new("https://api.edamam.com") do |f|
      f.params["app_id"] = ENV['EDAMAM_ID']
      f.params["app_key"] = ENV['EDAMAM_KEY']
    end
  end 
end 