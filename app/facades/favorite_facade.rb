class FavoriteFacade
  def self.list_favorites(user)
    favorites = user.favorites
    recipe_data[:hits].map do |one_recipe|
      Recipe.new(one_recipe, country)
    end
  end 
end 