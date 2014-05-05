require 'aws-sdk'
require 'dotenv'
Dotenv.load
        
puts ENV['AWS_ACCESS_KEY_ID']
puts ENV['AWS_SECRET_ACCESS_KEY']

AWS.config(
          :access_key_id => ENV['AWS_ACCESS_KEY_ID'], 
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
        )


        bucket_name = 'chriswendystyle'
        # file_name = 'images.jpeg'
        file_name = '/Users/chrispalmer/Desktop/images.jpeg'



        # Get an instance of the S3 interface.
        s3 = AWS::S3.new

        # Upload a file.
        key = File.basename(file_name)
        a = s3.buckets[bucket_name].objects[key].write(:file => file_name)
        puts "Uploading file #{file_name} to bucket #{bucket_name}."
        url = File.join("https://s3.amazonaws.com/chriswendystyle", key)

#         # bucket = s3.buckets[bucket_name]
#         # puts "buckets: #{s3.buckets.inspect} #{bucket}"

#         # bucket.objects.each do |obj|
#         # puts obj.key
#         # end


