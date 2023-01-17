class CountriesService 
  def self.get_list
      response = conn.get("/v2/all?fields=name") 
      JSON.parse(response.body,symbolize_names: true)
  end 

  def self.conn 
      Faraday.new("https://restcountries.com")
  end 
end 