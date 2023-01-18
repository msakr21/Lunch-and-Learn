require 'rails_helper'

RSpec.describe LearningResourcesService do 
  describe '.get_video' do
    it 'returns information about a youtube video, from the Mr. History channel, based on a country' do
      json_response = File.read('spec/fixtures/egypt_youtube.json')
      header = {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v2.7.3'}

      stub_request(:get, "https://youtube.googleapis.com/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&fields=items(id,snippet(title))&maxResults=1&part=snippet&q=Egypt&type=video")
      .with(headers: header, query: {"key" => ENV['GOOGLE_API-KEY']})
      .to_return(status: 200, body: json_response, headers: {})

      response = LearningResourcesService.get_video("Egypt")
      expect(response).to be_a Hash
      expect(response.keys).to eq([:items])
      expect(response[:items]).to be_a Array
      expect(response[:items].length).to eq(1)
      expect(response[:items].first).to be_a Hash
      expect(response[:items].first.keys).to eq([:id, :snippet])
      expect(response[:items].first[:id]).to have_key(:videoId)
      expect(response[:items].first[:id][:videoId]).to eq("2C25cTQF2jw")
      expect(response[:items].first[:snippet]).to be_a Hash
      expect(response[:items].first[:snippet].keys).to eq([:title])
      expect(response[:items].first[:snippet][:title]).to eq("A Super Quick History of Egypt")
    end
  end 

  describe '.get_images' do
    it 'returns a a hash with an array of hash elements containing information about images' do
      json_response = File.read('spec/fixtures/egypt_pexel.json')
      header = {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v2.7.3', 'Authorization'=> ENV['NOT_UNSPLASH']}

      stub_request(:get, "https://api.pexels.com/v1/search?per_page=10&query=Egypt")
      .with(headers: header)
      .to_return(status: 200, body: json_response, headers: {})

      response = LearningResourcesService.get_images("Egypt")
      expect(response).to be_a Hash
      expect(response).to have_key(:photos)
      expect(response[:photos]).to be_a Array
      expect(response[:photos].first).to be_a Hash
      expect(response[:photos].first.keys).to include(:alt, :url, :photographer, :photographer_url)
      expect(response[:photos].first[:alt]).to eq("Gray Pyramid on Dessert Under Blue Sky")
      expect(response[:photos].first[:url]).to eq("https://www.pexels.com/photo/gray-pyramid-on-dessert-under-blue-sky-71241/")
      expect(response[:photos].first[:photographer]).to eq("David McEachan")
      expect(response[:photos].first[:photographer_url]).to eq("https://www.pexels.com/@davidmceachan")
    end
  end
end 