require 'rails_helper'

RSpec.describe 'Get Recipes' , :type => :request do 
    before :each do
      
      json_response = File.read('spec/fixtures/egypt_edamam.json')
      country_response = File.read('spec/fixtures/countries.json')
      recipe_response = File.read('spec/fixtures/egypt_edamam.json')
      header = {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v2.7.3'}

      allow_any_instance_of(Array).to receive(:sample).and_return({name: "Egypt"})

      stub_request(:get, "https://api.edamam.com/api/recipes/v2?field=url&q=Egypt&type=public")
      .with(headers: header, query: {"app_id" => ENV['EDAMAM_ID'], "app_key" => ENV['EDAMAM_KEY']})
      .to_return(status: 200, body: recipe_response, headers: {})

      stub_request(:get, "https://restcountries.com/v2/all?fields=name")
      .with(headers: header)
      .to_return(status: 200, body: country_response, headers: {})

      stub_request(:get, "https://api.edamam.com/api/recipes/v2?field=url&q=Egypt&type=public")
      .with(headers: header, query: {"app_id" => ENV['EDAMAM_ID'], "app_key" => ENV['EDAMAM_KEY']})
      .to_return(status: 200, body: json_response, headers: {})

      stub_request(:get, "https://api.edamam.com/api/recipes/v2?field=url&type=public")
      .with(headers: header, query: {"app_id" => ENV['EDAMAM_ID'], "app_key" => ENV['EDAMAM_KEY']})
      .to_return(status: 200, body: json_response, headers: {})

      stub_request(:get, "https://api.edamam.com/api/recipes/v2?field=url&q=&type=public")
      .with(headers: header, query: {"app_id" => ENV['EDAMAM_ID'], "app_key" => ENV['EDAMAM_KEY']})
      .to_return(status: 200, body: {"data": []}.to_json, headers: {})
    end

    it 'returns a list of recipes as json' do 
        country = "Egypt"

        get "/api/v1/recipes?country=#{country}"

        expect(response).to be_successful
        parsed_response = JSON.parse(response.body,symbolize_names: true)
        expect(parsed_response).to be_a(Hash)
        expect(parsed_response.keys).to eq([:data])
        expect(parsed_response[:data]).to be_a(Array)
        expect(parsed_response[:data].first.keys).to eq([:id, :type, :attributes])
        expect(parsed_response[:data].first[:attributes].keys).to eq([:title, :url, :country, :image])
        expect(parsed_response[:data].first[:attributes][:title]).to eq("Dukkah (Middle Eastern Nut and Spice Blend) Recipe")
        expect(parsed_response[:data].first[:attributes][:url]).to eq("https://www.seriouseats.com/recipes/2019/06/dukkah.html")
        expect(parsed_response[:data].first[:attributes][:country]).to eq("Egypt")
        # expect(parsed_response[:data].first[:attributes][:image]).to eq("https://edamam-product-images.s3.amazonaws.com/web-img/b50/b50e8e9a5b4b5d58dd96beaf0ed6ae69.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjENL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIHYwO%2FG60Ukbbdo0qb2c4J%2BFVHP2N2jM2clzxGSptFyrAiEA5gnFbK%2B6TYjce7kJKelp3%2FXSjPQzGSZke4dobsytKHkqzAQIOxAAGgwxODcwMTcxNTA5ODYiDDCICLko%2B%2FOz8n9J3SqpBDGofLmDqK1WqEc2hAtlUyFLfKcOkWHotqs2cI1gaANyInsnZUKolCvlYwUfSKFcJWTWF1HV%2FYLcRofnUuP4hlyGbZdPkfLv5ubiTyw1Bq2i2gPLHpt%2BmgWODPWbm%2FJc6AaGUWD2X4gZ23813t%2Bj0lP8zqBwKdWTcJbA9aVVZqY6DqBn2EAOLMihpszo2qULdoq4mDEqvgpdFi%2FMrea6aO8%2B9nguUwaE6a2EW7wEYlWbBY71UHEckoSduvb2sLURDwSJ9FW%2BUkqvBlq7QmmIfl9QAUBp4GzLk56h%2F0JwTU40PoDasDTXLqEiLneZyMSqzmvRAQwobOjkY2bJ2SQqVCzefUcjBe%2FKPABGbjfWBSp0VX3uOR58f7REGbicXtRv2HNFYD5uHMRSvYpFkBbog24N7yLmBzo4dnYUbue3ACvUtl5F0IDJZ5YYB1S1xyDzvl%2F2ZqHfbHadl%2F4pqynt%2BbgRj%2BeE8nQgpWoZlVNJl4a2NjrPTvwXe8MAPKuinCRnUY4qJ9X4HqJUFMS89iXoKzP2qE0HXWZxRmePrNmju%2FDDwzuohP3%2FwfT4cUP4E4a1XRezeoodW8pcDgBYUkgXY7c9IcyPoxzAnYWGm2ednkP0yVJhVYw2XmPwHRD1iBZ6THti7wdZrwQvvdqIB9LX8u%2Bkd%2F6%2BXYoVllxmYJTAKCSaJxv7IRM6JPZndAyBnnHhJnZ0f6qS%2B5s2njAn%2Fo5AO%2BGliewzILWUcq8wuvqXngY6qQG%2FdUmJ2xs1XhExl2zp5Kzo%2FJ5MLkAjphKMlkyRJkiVaKHs7O67FnPSTmY%2FWjcZ9cLYpno2WIo306OgkfHHU04fB%2Bvy%2FpIxW1PlnmCLihDXtHP8jeXfn%2BcoOt%2F0bStKARsqualNwdHFWJXLa4fhaaC9w4xOr7WKP3LJEKFSbFyiSHzC8Iipuu9CsYBhVRvv2qfqdNx7TPwBPdcCwtlnC2Fd%2FA1DDG526O7h&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230117T025816Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFEV27VMGX%2F20230117%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=5d4331a788a8a2745328262a4b55e0027089f6cc7e828a919e2e64ebe9ef2f6a")
    end 

    it 'generates a random country if none is provided' do
      get "/api/v1/recipes"

      expect(response).to be_successful
      parsed_response = JSON.parse(response.body,symbolize_names: true)
      expect(parsed_response).to be_a(Hash)
      expect(parsed_response.keys).to eq([:data])
      expect(parsed_response[:data].first.keys).to eq([:id, :type, :attributes])
      expect(parsed_response[:data].first[:attributes].keys).to eq([:title, :url, :country, :image])
    end

    it "generates a hash with a key of data that has a blank array as a value if country is an empty string or there's no match" do
      get "/api/v1/recipes?country="

      expect(response).to be_successful
      parsed_response = JSON.parse(response.body,symbolize_names: true)
      expect(parsed_response).to eq({"data": []})
    end
end 