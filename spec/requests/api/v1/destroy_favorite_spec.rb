require 'rails_helper'

RSpec.describe 'Delete Favorites', :type => :request do
  before :each do
    @user = User.create(name: "Athena Dao One", email: "athenadao@bestgirlever.com", api_key: "jgn983hy48thw9begh98h4539h4")
    @favorite_1 = Favorite.new(country: "thailand", recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Crab Fried Rice (Khaao Pad Bpu)")
    @favorite_2 = Favorite.new(country: "egypt", recipe_link: "https://www.7amada.com/.....", recipe_title: "Mulukhiyya")
    @user.favorites << @favorite_1
    @user.favorites << @favorite_2

  end
  it 'deletes a favorite' do
    expect(@user.favorites.length).to eq(2)
    expect(@user.favorites).to include(@favorite_1, @favorite_2)
    expect(Favorite.all.length).to eq(2)
    expect(Favorite.all).to include(@favorite_1, @favorite_2)

    delete_info = {"api_key": "jgn983hy48thw9begh98h4539h4", "favorite_id": @favorite_1.id}
    delete '/api/v1/favorites', :headers => {"Content-Type" => "application/json", Accept: "application/json"}, params: delete_info.to_json

    user = User.find(@user.id)

    expect(response).to be_successful
    expect(user.favorites.length).to eq(1)
    expect(user.favorites).to include(@favorite_2)
    expect(Favorite.all.length).to eq(1)
    expect(Favorite.all).to include(@favorite_2)
    parsed_response = JSON.parse(response.body,symbolize_names: true)
    expect(parsed_response).to eq({"success": "Favorite deleted successfully"})
  end

  it 'renders an error json if invalid api_key' do
    expect(Favorite.all.length).to eq(2)
    expect(Favorite.all).to include(@favorite_1, @favorite_2)

    delete_info = {"api_key": "random_stuff", "favorite_id": @favorite_1.id}
    delete '/api/v1/favorites', :headers => {"Content-Type" => "application/json", Accept: "application/json"}, params: delete_info.to_json

    expect(response.status).to eq(404)
    expect(Favorite.all.length).to eq(2)
    expect(Favorite.all).to include(@favorite_1, @favorite_2)
    parsed_response = JSON.parse(response.body,symbolize_names: true)
    expect(parsed_response).to eq({error: "The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible.", code: 404, status: "Not Found"})
  end
end