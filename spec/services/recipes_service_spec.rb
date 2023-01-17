require 'rails_helper'

RSpec.describe RecipesService do 
    it '.get_recipe' do 
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