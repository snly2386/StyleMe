require 'spec_helper'

describe StyleMe::Databases::InMemory do
  let(:db) { StyleMe.db }

  before do 
    db.clear_everything
    @user = db.create_user(:username => "wendy", :name => "wen", :age=> 24, :gender => "female", :about_me => "beautiful", :password => "123")
  end

  it "creates a user" do
    user = db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123")
    expect(user.username).to eq('billybob')
    expect(user.name).to eq("bill")
    expect(user.closet).to be_a(StyleMe::Closet)
  end

  it "gets a user" do
    user = db.create_user(:username => "wendy", :name => "wen", :age=> 24, :gender => "female", :about_me => "beautiful", :password => "123")
    wen = db.get_user(user.id)
    expect(user.name).to eq('wen')
  end

  it "gets a closet" do 
     user = db.create_user(:username => "wendy", :name => "wen", :age=> 24, :gender => "female", :about_me => "beautiful", :password => "123")
     closet = db.get_closet(user.closet.id)
     expect(closet.user_id).to eq(user.id)
  end

  it "gets user by username" do 
    wendy = db.get_user_by_username("wendy")
    expect(wendy.username).to eq('wendy')
  end


  it "creates a photo" do 
    
    photo = db.create_photo(:user_id => @user.id, :url => "www.here")
    expect(photo.id).to_not be_nil

  end

  it "gets a photo" do 
    photo = db.create_photo(:user_id => @user.id, :url => "www.here")
    got_photo = db.get_photo(photo.id)
    expect(got_photo.url).to_not be_nil
  end

  it "creates a photobooth" do 
    user = db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123") 
    photo = db.create_photo(:user_id => user.id, :url => "www.here")
    photobooth = db.create_photobooth(:closet_id => user.closet.id, :photo_id => photo.id)
    expect(photobooth.id).to_not be_nil
    expect(photobooth.closet_id).to eq(user.closet.id)
  end

  it "gets a photobooth" do 
    user = db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123") 
    photo = db.create_photo(:user_id => user.id, :url => "www.here")
    photobooth = db.create_photobooth(:closet_id => user.closet.id, :photo_id => photo.id)
    got_photobooth = db.get_photobooth(photobooth.id)
    expect(got_photobooth.photo_id).to_not be_nil
  end

  it "creates a result" do 
    user = db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123") 
    photo = db.create_photo(:user_id => user.id, :url => "www.here")
    photobooth = db.create_photobooth(:closet_id => user.closet.id, :photo_id => photo.id) 
    result = db.create_result(:photobooth_id => photobooth.id)
    expect(result.id).to_not be_nil
  end

  it "gets a result" do 
    user = db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123") 
    photo = db.create_photo(:user_id => user.id, :url => "www.here")
    photobooth = db.create_photobooth(:closet_id => user.closet.id, :photo_id => photo.id) 
    result = db.create_result(:photobooth_id => photobooth.id)
    get_result = db.get_result(result.id)
    expect(get_result.photobooth_id).to eq(photobooth.id)
  end
end
