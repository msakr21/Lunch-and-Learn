require 'rails_helper'

RSpec.describe RecipesService do 
    describe '.get_recipe' do 
      it 'gets a list of recipes (with their labels, urls, and images) based on country' do
        json_response = File.read('spec/fixtures/egypt_edamam.json')
        header = {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v2.7.3'}

        stub_request(:get, "https://api.edamam.com/api/recipes/v2?field=url&q=Egypt&type=public")
        .with(headers: header, query: {"app_id" => ENV['EDAMAM_ID'], "app_key" => ENV['EDAMAM_KEY']})
        .to_return(status: 200, body: json_response, headers: {})

        response = RecipesService.get_recipe("Egypt")

        expect(response).to be_a Hash
        expect(response[:hits]).to be_a Array
        expect(response[:hits].first).to have_key :recipe
        expect(response[:hits].first[:recipe]).to have_key :label
        expect(response[:hits].first[:recipe]).to have_key :image
        expect(response[:hits].first[:recipe]).to have_key :url
        expect(response[:hits].first[:recipe].keys.length).to eq(3)
      end
    end 
end 