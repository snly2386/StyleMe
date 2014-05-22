require 'unirest'
require 'dotenv'
require 'aws-sdk'
Dotenv.load
# require 'pry-debugger'

module StyleMe
  class CreatePhotoBooth < UseCase
    def run(params)
      @db = StyleMe.db
      # url = params[:url]
  
      # photo_path = '/Users/chrispalmer/Desktop/' + params[:file_name].original_filename
      photo_path = params[:file_name]
      # url = upload_to_s3
      #-UPLOADED TO AMAZON S3 ------------------------------------
     AWS.config(
          :access_key_id => ENV['AWS_ACCESS_KEY_ID'], 
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
        )


        bucket_name = 'chriswendystyle'
        # file_name = 'images.jpeg'
        # file_name = '/Users/chrispalmer/Desktop/super.jpeg'



        # Get an instance of the S3 interface.
        s3 = AWS::S3.new
        #make url accessible to public
        # s3.buckets[bucket_name].acl = :public_read
        # b = s3.buckets[bucket_name].objects['target-key'].url_for(:write, :acl => :public_read)
        # Upload a file.
        key = photo_path.original_filename
        # key = File.basename(photo_path)
       
        image = s3.buckets[bucket_name].objects[key].write(:file => photo_path)
        puts "Uploading file #{photo_path} to bucket #{bucket_name}."
        # url = File.join("https://s3.amazonaws.com/chriswendystyle", key)
       

        doomsday = Time.mktime(2038, 1, 18).to_i
        image.public_url(:expires => doomsday)
        url_string = image.public_url.to_s
       
        # puts "public url"
        # puts image.public_url

      # Create empty photobooth
      photobooth = @db.create_photobooth(:tags => nil, :content => nil, :images => url_string, :user_id => params[:user_id])
      #create photo with file path
      photo = @db.create_photo(:file_name => key, :photobooth_id => photobooth.id)


   

      # buffer = File.open(photo_path.tempfile, "rb")
      # new_file = File.new(photo_path.original_filename, "wb")
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
        "image_request[remote_image_url]" => url_string
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
      success :results => @response, :file_name => params[:file_name].original_filename, :description => description, :photobooth => photobooth, :photo_path => photo_path, :response => @token_response
    end

    # def upload_to_s3
   
    #   #UPLOAD TO AMAZON S3--------------------------------------
    #   AWS.config(
    #     :access_key_id => ENV['AWS_ACCESS_KEY_ID'], 
    #     :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    #   )

    #   bucket_name = 'chriswendystyle'
    #   # file_name = photo_path
    #   

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