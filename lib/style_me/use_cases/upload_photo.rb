require 'aws-sdk'
require 'dotenv'
Dotenv.load

module StyleMe
  class UploadPhoto < UseCase
    def run(params)
      @db = StyleMe.db
      url = params[:url]
      return failure(:invalid_url) if url.empty?


      photo = @db.create_photo(:url => params[:url])

      AWS.config(
          :access_key_id => ENV['AWS_ACCESS_KEY_ID'], 
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
        )

        bucket_name = 'chriswendystyle'
        file_name = 'images.jpeg'

        # Get an instance of the S3 interface.
        s3 = AWS::S3.new

        # Upload a file.
        key = File.basename(file_name)
        s3.buckets[bucket_name].objects[key].write(:file => file_name)
        puts "Uploading file #{file_name} to bucket #{bucket_name}."
      success :photo => photo
    end
  end
end