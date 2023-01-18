require 'rails_helper'

RSpec.describe 'Post Favorite', :type => :request do 
  it 'creates a new favorite based on a json payload body if api key matches then renders a json response with a success message' do
    favorite_info = {"api_key": "jgn983hy48thw9begh98h4539h4",
                     "country": "thailand",
                     "recipe_link": "https://www.tastingtable.com/.....",
                     "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
                    }

    User.create(name: "Athena Dao One", email: "athenadao@bestgirlever.com", api_key: "jgn983hy48thw9begh98h4539h4")

    expect(Favorite.all.length).to eq(0)

    post '/api/v1/favorites', :headers => {"Content-Type" => "application/json", Accept: "application/json"}, params: favorite_info.to_json
    
    expect(response).to be_successful
    parsed_response = JSON.parse(response.body,symbolize_names: true)

    expect(Favorite.all.length).to eq(1)
    expect(parsed_response).to be_a Hash
    expect(parsed_response.keys).to eq([:success])
    expect(parsed_response[:success]).to eq("Favorite added successfully")
  end

  it 'renders an error message if no user with that api_key exists' do
    favorite_info = {"api_key": "jgn983hy48thw9begh98h4539h4",
      "country": "thailand",
      "recipe_link": "https://www.tastingtable.com/.....",
      "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
     }

    expect(Favorite.all.length).to eq(0)

    post '/api/v1/favorites', :headers => {"Content-Type" => "application/json", Accept: "application/json"}, params: favorite_info.to_json

    expect(response.status).to eq(404)
    parsed_response = JSON.parse(response.body,symbolize_names: true)

    expect(Favorite.all.length).to eq(0)
    expect(parsed_response).to be_a Hash
    expect(parsed_response.keys).to eq([:error, :code, :status])
    expect(parsed_response[:error]).to eq("The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible.")
    expect(parsed_response[:code]).to eq(404)
    expect(parsed_response[:status]).to eq("Not Found")
  end
end