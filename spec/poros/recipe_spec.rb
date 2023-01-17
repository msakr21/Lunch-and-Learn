require 'rails_helper'

RSpec.describe Recipe do 
    it 'exists and has attributes' do 
        recipe_info = { :recipe => {
                            :label=>"Dukkah (Middle Eastern Nut and Spice Blend) Recipe", 
                            :url=>"https://www.seriouseats.com/recipes/2019/06/dukkah.html", 
                            :image=>"/image"
                        } }
        country = "Egypt"

        recipe= Recipe.new(recipe_info,country)

        expect(recipe).to be_an_instance_of(Recipe)
        expect(recipe.title).to eq("Dukkah (Middle Eastern Nut and Spice Blend) Recipe")
        expect(recipe.url).to eq("https://www.seriouseats.com/recipes/2019/06/dukkah.html")
        expect(recipe.image).to eq("/image")
        expect(recipe.country).to eq("Egypt")
    end 
end 