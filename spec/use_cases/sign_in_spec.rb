require 'spec_helper'

describe StyleMe::SignIn do
  # let(:game) { StyleMe.db.create_game :players => ['Alice', 'Bob'] }
  # let(:result) { described_class.run(@params) }

  before do
   @db = StyleMe.db
   @result = @db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "12345")
  end

  describe "Error handling" do
    it "ensures the username is valid" do
      result = subject.run(:username=> "hithere", :password=>"12345")
      expect(result.success?).to eq false
      expect(result.error).to eq :no_user_exists
    end

    it "ensures the password is correct" do
     result = subject.run(:username=>"billybob", :password=>"123456")
      expect(result.success?).to eq false
      expect(result.error).to eq :invalid_password
    end

    it "signs the user in and creates a session" do
      result = subject.run(:username=> "billybob", :password => "12345")
      expect(result.success?).to eq true
      expect(result.user).to be_a StyleMe::User
      expect(result.session).to be_a StyleMe::Session
    end
  end
end
