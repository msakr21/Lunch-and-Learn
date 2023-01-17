require 'rails_helper'

RSpec.describe 'Post User', :type => :request do 
  it 'creates a new user based on a json payload body and generates an api key for them then renders a json response with the user data' do
    user_info = {"name": "Athena Dao", "email": "athenadao@bestgirlever.com"}
    
    expect(User.all.length).to eq(0)

    post '/api/v1/users', :headers => {"Content-Type" => "application/json", Accept: "application/json"}, params: user_info.to_json
    
    expect(response).to be_successful
    parsed_response = JSON.parse(response.body,symbolize_names: true)

    expect(User.all.length).to eq(1)
    expect(parsed_response).to be_a Hash
    expect(parsed_response.keys).to eq([:data])
    expect(parsed_response[:data]).to be_a Hash
    expect(parsed_response[:data].keys).to eq([:id, :type, :attributes])
    expect(parsed_response[:data][:id]).to eq("#{User.last.id}")
    expect(parsed_response[:data][:attributes]).to be_a Hash
    expect(parsed_response[:data][:attributes].keys).to eq([:name, :email, :api_key])
    expect(parsed_response[:data][:attributes][:name]).to eq("Athena Dao")
    expect(parsed_response[:data][:attributes][:email]).to eq("athenadao@bestgirlever.com")
    expect(parsed_response[:data][:attributes][:api_key]).to eq(User.last.api_key)
  end

  it 'renders an error message if email is not unique' do
    User.create(name: "Athena Dao One", email: "athenadao@bestgirlever.com", api_key: SecureRandom.urlsafe_base64)

    user_info = {"name": "Athena Dao", "email": "athenadao@bestgirlever.com"}

    post '/api/v1/users', :headers => {"Content-Type" => "application/json", Accept: "application/json"}, params: user_info.to_json

    expect(response).to be_successful
    parsed_response = JSON.parse(response.body,symbolize_names: true)
    
    expect(parsed_response).to eq({Error: "This email is already in use. Please use another one."})
  end
end