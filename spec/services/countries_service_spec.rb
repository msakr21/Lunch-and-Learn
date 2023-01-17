require 'rails_helper'

RSpec.describe CountriesService do 
    describe '.get_list' do 
      it 'returns an array of 250 elements each being a name of a country' do
        response = CountriesService.get_list
        expect(response).to be_a Array
        expect(response.length).to eq(250)
        expect(response.first.keys).to eq([:name, :independent])
        expect(response.first[:name]).to eq("Afghanistan")
      end
    end 
end 