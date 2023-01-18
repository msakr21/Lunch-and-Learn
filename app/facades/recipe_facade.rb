class RecipeFacade
  def self.recipe_info(country)
    recipe_data = RecipesService.get_recipe(country)
    if recipe_data[:hits].present?
      recipe_data[:hits].map do |one_recipe|
        Recipe.new(one_recipe, country)
      end
    else
      nil
    end
  end 
end 