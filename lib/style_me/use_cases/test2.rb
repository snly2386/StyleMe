require 'unirest'
require 'dotenv'
Dotenv.load
@token_response = Unirest::post "https://camfind.p.mashape.com/image_requests", 
  headers: { 
    "X-Mashape-Authorization" => ENV["NEW_CAMFIND_KEY"]
  },
  parameters: { 
    "image_request[locale]" => "en_US",
    "image_request[language]" => "en",
    "image_request[device_id]" => "<image_request[device_id]>",
    "image_request[latitude]" => "35.8714220766008",
    "image_request[longitude]" => "14.3583203002251",
    "image_request[altitude]" => "27.912109375",
    "focus[x]" => "480",
    "focus[y]" => "640",
    "image_request[remote_image_url]" => "https://s3.amazonaws.com/chriswendystyle/super.jpeg"
    
  }
  puts "CAMFIND SHIIIT:"
  puts ENV["NEW_CAMFIND_KEY"]

def make_request
  @response = Unirest::get("https://camfind.p.mashape.com/image_responses/" + @token_response.body['token'],
    headers: { 
      "X-Mashape-Authorization" => ENV["NEW_CAMFIND_KEY"]
    }
  )
end
