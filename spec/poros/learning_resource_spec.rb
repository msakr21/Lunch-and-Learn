require 'rails_helper'

RSpec.describe LearningResource do 
  before :each do
    @video_info = {:items => [
                              {
                                :id => {
                                        :kind => "youtube#video",
                                        :videoId => "2C25cTQF2jw"
                                      },
                                :snippet => {
                                              :title => "A Super Quick History of Egypt"
                                            }
                              }
                            ]
                    }

    @images_data = {:photos => [{:url => "https://www.pexels.com/photo/gray-pyramid-on-dessert-under-blue-sky-71241/",
                     :photographer => "David McEachan",
                     :photographer_url => "https://www.pexels.com/@davidmceachan",
                     :alt => "Gray Pyramid on Dessert Under Blue Sky"
                    }]}

    @images_data2 = {:photos =>[{:url => "something else",
                      :photographer => "Who now?",
                      :photographer_url => "This is a lot of work!",
                      :alt => "Mostafa crying his eyeballs out!"
                    }]}

    @country = "Egypt"
  end

  it 'exists and has attributes' do 
      learning_resource= LearningResource.new(@video_info, @images_data, @country)

      expect(learning_resource).to be_an_instance_of(LearningResource)
      expect(learning_resource.country).to eq("Egypt")
      expect(learning_resource.video).to be_a(Hash)
      expect(learning_resource.video.keys).to eq(["title", "youtube_video_id"])
      expect(learning_resource.video["title"]).to eq("A Super Quick History of Egypt")
      expect(learning_resource.video["youtube_video_id"]).to eq("2C25cTQF2jw")
      expect(learning_resource.images).to be_a(Array)
      expect(learning_resource.images.first).to be_a(Hash)
      expect(learning_resource.images.first.keys.length).to eq(4)
      expect(learning_resource.images.first.keys).to include("url", "photographer", "photographer_pexel_page", "alt_tag")
      expect(learning_resource.images.first["url"]).to eq("https://www.pexels.com/photo/gray-pyramid-on-dessert-under-blue-sky-71241/")
      expect(learning_resource.images.first["photographer"]).to eq("David McEachan")
      expect(learning_resource.images.first["photographer_pexel_page"]).to eq("https://www.pexels.com/@davidmceachan")
      expect(learning_resource.images.first["alt_tag"]).to eq("Gray Pyramid on Dessert Under Blue Sky")
  end 

  it 'has a method that adds cleaned up raw data from pexels to the images attribute' do
    learning_resource= LearningResource.new(@video_info, @images_data, @country)

    learning_resource.add_image_info(@images_data2)
    expect(learning_resource.images[1]["url"]).to eq("something else")
    expect(learning_resource.images[1]["photographer"]).to eq("Who now?")
    expect(learning_resource.images[1]["photographer_pexel_page"]).to eq("This is a lot of work!")
    expect(learning_resource.images[1]["alt_tag"]).to eq("Mostafa crying his eyeballs out!")
  end
end 