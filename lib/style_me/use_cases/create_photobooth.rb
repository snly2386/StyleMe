require 'unirest'
require 'dotenv'
Dotenv.load
# require 'pry-debugger'

module StyleMe
  class CreatePhotoBooth < UseCase
    def run(params)
      @db = StyleMe.db
      # url = params[:url]
      @image_path = params[:file_name]
      # url = upload_to_s3
      #-UPLOADED TO AMAZON S3 ------------------------------------

      # Create empty photobooth
      photobooth = @db.create_photobooth(:tags => nil, :content => nil, :images => nil, :user_id => nil)
      #create photo with Amazon url and file path


      photo_path = '/Users/chrispalmer/Desktop/' + params[:file_name].original_filename
      photo = @db.create_photo(:file_name => photo_path, :photobooth_id => photobooth.id)

      #Retrieve photo with CAMFIND
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
        "image_request[image]" => File.new('/Users/chrispalmer/Desktop/' + params[:file_name].original_filename)
      }

      # def make_request
      @response = Unirest::get("https://camfind.p.mashape.com/image_responses/" + @token_response.body['token'],
        headers: { 
          "X-Mashape-Authorization" => ENV["NEW_CAMFIND_KEY"]
        }
      )
      
      
      MisterWorker.perform_in(15.seconds, @token_response.body['token'], photobooth.id)
      description = @response.body["name"]
      
      # params[:url] = url
      success :results => @response, :file_name => params[:file_name].original_filename, :description => description, :photobooth => photobooth, :photo_path => photo_path
    end

    # def upload_to_s3
   
    #   #UPLOAD TO AMAZON S3--------------------------------------
    #   AWS.config(
    #     :access_key_id => ENV['AWS_ACCESS_KEY_ID'], 
    #     :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    #   )

    #   bucket_name = 'chriswendystyle'
    #   # file_name = photo_path
    #   file_name = get_photo.file_name

    #   # Get an instance of the S3 interface.
    #   s3 = AWS::S3.new

    #   # Upload a file.
    #   key = File.basename(file_name)
    #   s3.buckets[bucket_name].objects[key].write(:file => file_name)
    #   url = File.join("https://s3.amazonaws.com/chriswendystyle", key)
    #   puts "Uploading file #{file_name} to bucket #{bucket_name}."
    #   return url
    # end
  end
end