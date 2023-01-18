require 'rails_helper'

RSpec.describe CountriesService do 
    describe '.get_list' do 
      it 'returns an array of 250 elements each being a name of a country' do
        json_response = File.read('spec/fixtures/countries.json')
        header = {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v2.7.3'}

        stub_request(:get, "https://restcountries.com/v2/all?fields=name")
        .with(headers: header)
        .to_return(status: 200, body: json_response, headers: {})
        response = CountriesService.get_list
        expect(response).to be_a Array
        expect(response.length).to eq(250)
        expect(response.first.keys).to eq([:name, :independent])
        expect(response.first[:name]).to eq("Afghanistan")
      end
    end 
end 