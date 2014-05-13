require 'spec_helper'
require 'time'

describe StyleMe::LoadPhotoBooth do

  let(:result) { described_class.run(@params) }

  before do
    @photo = photo = StyleMe.db.create_photo(:file_name => 'some/file.jpg')
    @photobooth = StyleMe.db.create_photobooth(
      :tags => nil,
      :content => nil,
      :images => nil,
      :user_id => nil
    )
    @photo.photobooth_id = @photobooth.id
    @params = {
      :token => 'kumc9wRdQRAO5lNzmFpe3g',
      :photobooth_id => @photobooth.id
    }
    Time.stub(:now).and_return(Time.parse '2014-05-12T14:59:31Z')
  end

  it "updates the photobooth tags" do
    VCR.use_cassette('camfind_success') do
      expect(result.photobooth.tags).to_not be_nil
      expect(result.search_results).to_not be_empty
    end
  end

end
