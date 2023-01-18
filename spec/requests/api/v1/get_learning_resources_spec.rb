require 'rails_helper'

RSpec.describe 'Get LearningResources', :type => :request do
  before :each do
    json_response = File.read('spec/fixtures/egypt_youtube.json')
    header = {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v2.7.3'}

    stub_request(:get, "https://youtube.googleapis.com/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&fields=items(id,snippet(title))&maxResults=1&part=snippet&q=Egypt&type=video")
    .with(headers: header, query: {"key" => ENV['GOOGLE_API_KEY']})
    .to_return(status: 200, body: json_response, headers: {})

    pexel_response = File.read('spec/fixtures/egypt_pexel.json')
    pexel_header = {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v2.7.3', 'Authorization'=> ENV['NOT_UNSPLASH']}

    stub_request(:get, "https://api.pexels.com/v1/search?per_page=10&query=Egypt")
    .with(headers: pexel_header)
    .to_return(status: 200, body: pexel_response, headers: {})
  end

  it 'returns a hash with the name of the country, a video about the country, and images of it' do
    country = "Egypt"

    get "/api/v1/learning_resources?country=#{country}"

    expect(response).to be_successful
    parsed_response = JSON.parse(response.body,symbolize_names: true)
    expect(parsed_response).to be_a(Hash)
    expect(parsed_response.keys).to eq([:data])
    expect(parsed_response[:data].keys).to eq([:id, :type, :attributes])
    expect(parsed_response[:data][:attributes].keys).to eq([:country, :video, :images])
    expect(parsed_response[:data][:attributes][:country]).to eq("Egypt")
    expect(parsed_response[:data][:attributes][:video]).to be_a(Hash)
    expect(parsed_response[:data][:attributes][:video].keys).to eq([:title, :youtube_video_id])
    expect(parsed_response[:data][:attributes][:video][:title]).to eq("A Super Quick History of Egypt")
    expect(parsed_response[:data][:attributes][:video][:youtube_video_id]).to eq("2C25cTQF2jw")
    expect(parsed_response[:data][:attributes][:images]).to be_a(Array)
    expect(parsed_response[:data][:attributes][:images].length).to eq(10)
    expect(parsed_response[:data][:attributes][:images].first).to be_a(Hash)
    expect(parsed_response[:data][:attributes][:images].first.keys.length).to eq(4)
    expect(parsed_response[:data][:attributes][:images].first.keys).to include(:alt_tag, :url, :photographer, :photographer_pexel_page)
    expect(parsed_response[:data][:attributes][:images].first[:alt_tag]).to eq("Gray Pyramid on Dessert Under Blue Sky")
    expect(parsed_response[:data][:attributes][:images].first[:url]).to eq("https://www.pexels.com/photo/gray-pyramid-on-dessert-under-blue-sky-71241/")
    expect(parsed_response[:data][:attributes][:images].first[:photographer]).to eq("David McEachan")
    expect(parsed_response[:data][:attributes][:images].first[:photographer_pexel_page]).to eq("https://www.pexels.com/@davidmceachan")
  end
end