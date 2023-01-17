class RecipeFacade
  def self.recipe_info(country)
    recipe_data = RecipesService.get_recipe(country)
    recipe_data[:hits].map do |one_recipe|
      Recipe.new(one_recipe, country)
    end
  end 
end 