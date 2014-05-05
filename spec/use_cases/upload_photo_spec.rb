# require 'spec_helper'


# describe StyleMe::UploadPhoto do

#   it "returns error if url is not valid" do
#     result = subject.run(:url => "")
#     expect(result.success?).to eq(false)
#     expect(result.error).to eq(:invalid_url)
#   end

#   it "uploads a photo" do
#     VCR.use_cassette('s3_and_camfind') do
#       result = subject.run(:image_file => File.new('/.....') )
#       expect(result.success?).to eq(true)
#       expect(result.photo).to be_a StyleMe::Photo
#       expect(result.photo.url).to be_a '...[based on image file name]...'
#     end

#   end
# end

