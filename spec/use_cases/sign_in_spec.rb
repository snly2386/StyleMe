require 'spec_helper'

describe StyleMe::SignIn do
  # let(:game) { StyleMe.db.create_game :players => ['Alice', 'Bob'] }
  # let(:result) { described_class.run(@params) }

  before do
   @db = StyleMe.db
   # @result = @db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123456")
  end

  describe "Error handling" do
    it "ensures the username is valid" do
      result = subject.run(:username=> "hellllothere", :password=>"1234567")
      expect(result.success?).to eq false
      expect(result.error).to eq :no_user_exists
    end

    it "ensures the password is correct" do
      StyleMe.db.create_user(:username => "billybob", :name=> "bill", :email=> "billy@example.com", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123456")
     result = subject.run(:username=>"billybob", :password=>"123456asd")
      expect(result.success?).to eq false
      expect(result.error).to eq :invalid_password
    end

    it "signs the user in and creates a session" do
      StyleMe.db.create_user(:username => "bahbah", :name=> "bill", :email=> "billy123@example.com",:age=> 100, :gender => "male", :about_me =>"redneck", :password => "1234567")
      result = subject.run(:username=> "bahbah", :password => "1234567")
      expect(result.success?).to eq true
      expect(result.user).to be_a StyleMe::User
      expect(result.session).to be_a StyleMe::Session
    end
  end
end
