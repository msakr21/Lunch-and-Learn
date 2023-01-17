require 'rails_helper'

RSpec.describe CountriesService do 
    it '.get_recipe' do 
        response = CountriesService.get_list
        expect(response).to be_a Array
        expect(response.length).to eq(250)
        expect(response.first.keys).to eq([:name, :independent])
        expect(response.first[:name]).to eq("Afghanistan")
    end 
end 