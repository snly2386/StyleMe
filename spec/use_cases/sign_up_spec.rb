require 'spec_helper'

describe StyleMe::SignUp do

   before do
     @result = subject.run(:name=> "wendy", :username=>"wen", :age=>24, :gender => "female", :about_me => "fashionista", :password => "helloo1")
   end

  describe "Error handling" do
    it "returns error if username is taken" do
      result2 = subject.run(:name=> "wendy", :username=>"wen", :age=>24, :gender => "female", :about_me => "fashionista", :password => "123456")
      expect(result2.success?).to eq false
      expect(result2.error).to eq :username_taken
    end

    it "returns error if password invalid" do
      result2 = subject.run(:name=> "wendy", :username=>"wenddd", :age=>24, :gender => "female", :about_me => "fashionista", :password => "123")
      expect(result2.success?).to eq false
      expect(result2.error).to eq :invalid_password
    end
  end

  it "creates a user" do
      result = subject.run(:name=> "wendy", :username=>"wen567", :age=>24, :gender => "female", :about_me => "fashionista", :password => "helloo1")
      expect(result.success?).to eq true
      expect(result.user).to be_a StyleMe::User
    end
  end
