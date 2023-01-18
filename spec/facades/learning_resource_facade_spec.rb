require 'rails_helper'

RSpec.describe LearningResourceFacade do 
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
  
  it 'returns a learning resource object that has information on the country, a video and images as attributes' do
    learning_resource= LearningResourceFacade.resource_list("Egypt")
    expect(learning_resource.country).to eq("Egypt")
    expect(learning_resource.video).to be_a(Hash)
    expect(learning_resource.video.keys.length).to eq(2)
    expect(learning_resource.video.keys).to include("title", "youtube_video_id")
    expect(learning_resource.images).to be_a(Array)
    expect(learning_resource.images.length).to eq(10)
    expect(learning_resource.images.first).to be_a(Hash)
    expect(learning_resource.images.first.keys.length).to eq(4)
    expect(learning_resource.images.first.keys).to include("url", "photographer", "photographer_pexel_page", "alt_tag")
  end
end 