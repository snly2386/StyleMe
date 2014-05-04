require 'spec_helper'

describe StyleMe::UploadPhoto do 

  it "returns error if url is not valid" do 
    result = subject.run(:url => "")
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_url)
  end

end