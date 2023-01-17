require 'rails_helper'

RSpec.describe LearningResourcesService do 
    describe '.get_videos' do 
      it 'returns information about a youtube video, from the Mr. History channel, based on a country' do
        response = LearningResourcesService.get_videos("Egypt")
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
      'returns a a hash with an array of hash elements containing information about images' do
        response = LearningResourcesService.get_images("Egypt")
        expect(response).to be_a Hash
        expect(response.keys).to have_key(:photos)
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