require 'spec_helper'

shared_examples 'a database' do
  let(:db) { described_class.new('test') }

  before do
    db.clear_everything
    @user = db.create_user(:username => "wen", :name => "wendy", :age=> 24, :gender => "female", :about_me => "beautiful", :password => "123tree1", :password_digest=>"123tree1", :email=>"wendy@hotmail.com")

  end

  it "creates a user" do
    user = db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123456", :password_digest=>"123456", :email=>"wghhhjjj@hotmail.com")
    expect(user.id).to_not be_nil
    expect(user.username).to eq('billybob')
    expect(user.name).to eq("bill")
    # expect(user.closet).to be_a(StyleMe::Closet)
  end

  it "gets a user" do
    user = db.create_user(:username => "wendy123", :name => "wendy", :age=> 24, :gender => "female", :about_me => "bleh", :password => "123456", :password_digest=>"123456", :email=>"wasdfasdfadsf@hotmail.com")
    wen = db.get_user(user.id)
    expect(user.name).to eq('wendy')
  end

  it "creates a session" do
    user = db.create_user(:username => "wendy", :name => "wen", :age=> 24, :gender => "female", :about_me => "beautiful", :password => "123456", :password_digest=>"123456", :email=>"wendttty@hotmail.com")
    session = db.create_session(:user_id => user.id)
    expect(session.id).to_not be_nil
  end

  it "gets a session" do
    user = db.create_user(:username => "wendy", :name => "wen", :age=> 24, :gender => "female", :about_me => "beautiful", :password => "123456", :password_digest=>"123456", :email=>"woejfgkso@hotmail.com")
    session = db.create_session(:user_id => user.id)
    got_session = db.get_session(session.id)
    expect(got_session.id).to eq(session.id)
    expect(got_session.user_id).to eq(user.id)
  end

  it "gets a session by user_id" do
    user = db.create_user(:username => "wendy", :name => "wen", :age=> 24, :gender => "female", :about_me => "beautiful", :password => "123456", :password_digest=>"123456", :email=>"b@hotmail.com")
    session = db.create_session(:user_id => user.id)
    get_session = db.get_session_by_user_id(user.id)
    expect(get_session.user_id).to eq(user.id)
  end

  it "gets a closet" do
    user = db.create_user(:username => "wendy", :name => "wen", :age=> 24, :gender => "female", :about_me => "bubbles", :password => "123456", :password_digest=>"123456", :email=>"c@hotmail.com")
    closet = db.create_closet(:user_id => user.id)
    closet_get = db.get_closet(closet.id)
    expect(closet.user_id).to eq(user.id)
  end

  it "gets user by username" do
    wendy = db.get_user_by_username("wen")
    expect(wendy.username).to eq('wen')
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
    user = db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123456", :password_digest=>"123456", :email=>"g@hotmail.com")
    photo = db.create_photo(:user_id => user.id, :url => "www.here")
    closet = db.create_closet(:user_id => user.id)
    photobooth = db.create_photobooth(:closet_id => closet.id, :photo_id => photo.id)
    expect(photobooth.id).to_not be_nil
    expect(photobooth.closet_id).to eq(closet.id)
  end

  it "gets a photobooth" do
    user = db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123", :password_digest=>"123", :email=>"wendy@hotmail.com")
    photo = db.create_photo(:user_id => user.id, :url => "www.here")
    closet = db.create_closet(:user_id => user.id)
    photobooth = db.create_photobooth(:closet_id => closet.id, :photo_id => photo.id)
    got_photobooth = db.get_photobooth(photobooth.id)
    expect(got_photobooth.photo_id).to_not be_nil
  end

  xit "creates a result" do
    user = db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123", :password_digest=>"123", :email=>"wendy@hotmail.com")
    photo = db.create_photo(:user_id => user.id, :url => "www.here")
    photobooth = db.create_photobooth(:closet_id => user.closet.id, :photo_id => photo.id)
    result = db.create_result(:photobooth_id => photobooth.id)
    expect(result.id).to_not be_nil
  end

  xit "gets a result" do
    user = db.create_user(:username => "billybob", :name=> "bill", :age=> 100, :gender => "male", :about_me =>"redneck", :password => "123", :password_digest=>"123", :email=>"wendy@hotmail.com")
    photo = db.create_photo(:user_id => user.id, :url => "www.here")
    photobooth = db.create_photobooth(:closet_id => user.closet.id, :photo_id => photo.id)
    result = db.create_result(:photobooth_id => photobooth.id)
    get_result = db.get_result(result.id)
    expect(get_result.photobooth_id).to eq(photobooth.id)
  end
end
