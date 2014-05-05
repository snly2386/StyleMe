# require 'aws-sdk'
# require 'dotenv'
# Dotenv.load

# module StyleMe
#   class UploadPhoto < UseCase
#     def run(params)
#       @db = StyleMe.db
#       url = params[:url]
#       image_file = params[:image_file]
#       return failure(:invalid_url) if url.empty?


#       #UPLOAD TO AMAZON S3--------------------------------------
#       AWS.config(
#           :access_key_id => ENV['AWS_ACCESS_KEY_ID'], 
#           :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
#         )

#         bucket_name = 'chriswendystyle'
#         # file_name = 'images.jpeg'
#         file_name = image_file

#         # Get an instance of the S3 interface.
#         s3 = AWS::S3.new

#         # Upload a file.
#         key = File.basename(file_name)
#         s3.buckets[bucket_name].objects[key].write(:file => file_name)
#         url = File.join("https://s3.amazonaws.com/chriswendystyle", key)
#         puts "Uploading file #{file_name} to bucket #{bucket_name}."
#         #-UPLOADED TO AMAZON S3 ------------------------------------

#         #Retrieve photo with CAMFIND
#         @token_response = Unirest::post "https://camfind.p.mashape.com/image_requests", 
#         headers: { 
#           "X-Mashape-Authorization" => ENV["CAMFIND_KEY"]
#         },
#         parameters: { 
#           "image_request[locale]" => "en_US",
#           "image_request[language]" => "en",
#           "image_request[device_id]" => "<image_request[device_id]>",
#           "image_request[latitude]" => "35.8714220766008",
#           "image_request[longitude]" => "14.3583203002251",
#           "image_request[altitude]" => "27.912109375",
#           "focus[x]" => "480",
#           "focus[y]" => "640",
#           # "image_request[image]" => File.new(url)
#           "image_request[image]" => File.new(params[:image_file])
#         }

#       def make_request
#           @response = Unirest::get("https://camfind.p.mashape.com/image_responses/" + @token_response.body['token'],
#           headers: { 
#             "X-Mashape-Authorization" => ENV["CAMFIND_KEY"]
#           }
#         )
#       end

#         photo = @db.create_photo(:url => params[:url])
#         success :photo => photo
#     end
#   end
# end