require 'rails_helper'

RSpec.describe LearningResourceFacade do 
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