require 'rails_helper'

RSpec.describe 'Get Favorites', :type => :request do
  it 'returns a hash response that has a list of favorite recipe and information about each recipe' do
    user = User.create(name: "Athena Dao One", email: "athenadao@bestgirlever.com", api_key: "jgn983hy48thw9begh98h4539h4")
    user.favorites << Favorite.new(country: "thailand", recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Crab Fried Rice (Khaao Pad Bpu)")
    user.favorites << Favorite.new(country: "thailand", recipe_link: "https://www.7amada.com/.....", recipe_title: "Mulukhiyya")

    get "/api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h4"

    expect(response).to be_successful
    parsed_response = JSON.parse(response.body,symbolize_names: true)
    expect(parsed_response).to be_a(Hash)
    expect(parsed_response.keys).to eq([:data])
    expect(parsed_response[:data]).to be_a(Array)
    expect(parsed_response[:data].length).to eq(2)
    expect(parsed_response[:data].first.keys).to eq([:id, :type, :attributes])
    expect(parsed_response[:data].first[:attributes].keys).to eq([:recipe_title, :recipe_link, :country, :created_at])
    expect(parsed_response[:data].first[:attributes][:recipe_title]).to eq("Crab Fried Rice (Khaao Pad Bpu)")
    expect(parsed_response[:data].first[:attributes][:recipe_link]).to eq("https://www.tastingtable.com/.....")
    expect(parsed_response[:data].first[:attributes][:country]).to eq("thailand")
    expect(parsed_response[:data].first[:attributes][:created_at]).to eq(Favorite.find_by(country: "thailand").created_at.as_json)
  end

  it 'has an empty array value for the :data key if no favorites' do
    user = User.create(name: "Athena Dao One", email: "athenadao@bestgirlever.com", api_key: "jgn983hy48thw9begh98h4539h4")

    get "/api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h4"

    expect(response).to be_successful
    parsed_response = JSON.parse(response.body,symbolize_names: true)
    expect(parsed_response).to be_a(Hash)
    expect(parsed_response.keys).to eq([:data])
    expect(parsed_response[:data]).to be_a(Array)
    expect(parsed_response[:data]).to eq([])
  end

  it 'returns an error message and code if api_key is invalid' do
    get "/api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h4"

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