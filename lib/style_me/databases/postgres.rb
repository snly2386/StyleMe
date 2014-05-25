require 'yaml'
require 'active_record'
require 'pry-debugger'

module StyleMe
  module Databases
    class PostGres
      def initialize(env)

        config = YAML.load_file('db/config.yml')[env]
        ActiveRecord::Base.establish_connection(
          YAML.load_file('db/config.yml')[env]
        )
      end

      def clear_everything
        Session.destroy_all
        User.destroy_all
        Closet.destroy_all
        Photobooth.destroy_all
        Photo.destroy_all
        Result.destroy_all
      end

      class Session < ActiveRecord::Base
        has_one :user
        # mount_uploader :images, ImageUploader
      end

      class User < ActiveRecord::Base
        has_one :closet
        before_save { self.email = email.downcase }
        validates :name, presence: true

        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
        validates :password, length: {minimum: 6}
        # has_secure_password
      end

      class Closet < ActiveRecord::Base
        belongs_to :user
        has_many :photobooths
      end

      class Photobooth < ActiveRecord::Base
        has_one :photo
        has_many :results
      end

      class Photo <ActiveRecord::Base
        belongs_to :photobooth
      end

      class Result < ActiveRecord::Base
        belongs_to :photobooth
      end

      #Database Methods
      def create_user(attrs)
        ar_user = User.create(attrs)
        StyleMe::User.new(ar_user.attributes)
      end

      def get_user(id)
        id = id.to_i
        # user = StyleMe::User.new(User.find(id).attributes)
        User.find(id)
      end

      def get_user_by_username(username)
        ar_user = User.where(:username =>username).first
        return nil if ar_user.nil?

        StyleMe::User.new(ar_user.attributes)
      end

      def create_session(attrs)
        ar_session = Session.create(attrs)
        StyleMe::Session.new(ar_session.attributes)
      end

      def get_session(id)
        # session = StyleMe::Session.new(Session.find(id).attributes)
        Session.find(id)

      end

      def get_session_by_user_id(user_id)
        ar_session = Session.where(:user_id => user_id).first
        StyleMe::Session.new(ar_session.attributes)
      end

      def create_closet(attrs)
        ar_closet = Closet.create(attrs)
        StyleMe::Closet.new(ar_closet.attributes)
      end

      def get_closet(id)
        closet = StyleMe::Closet.new(Closet.find(id).attributes)
      end

      def create_photo(attrs)
        ar_photo = Photo.create(attrs)
        StyleMe::Photo.new(ar_photo.attributes)
      end

      def get_photo(id)
        # photo = StyleMe::Photo.new(Photo.find(id).attributes)
        Photo.find(id)
      end

      def create_photobooth(attrs)
        ar_photobooth = Photobooth.create(attrs)
        StyleMe::Photobooth.new(ar_photobooth.attributes)
      end

      def get_photobooth(id)
        # photobooth = StyleMe::Photobooth.new(Photobooth.find(id).attributes)
        Photobooth.find(id)
      end

      def get_all_photobooths_by_user_id(id)
        ar_photobooth = Photobooth.where(:user_id => id)
        ar_photobooth.each do |photobooth|
          StyleMe::Photobooth.new(photobooth.attributes)
        end
        ar_photobooth
      end

      def get_all_photobooths
        ar_photobooths = Photobooth.all
        ar_photobooths.each do |photobooth| 
          StyleMe::Phothobooth.new(photobooth.attributes)
        end
        ar_photobooths
      end

      def update_photobooth(id, attrs)
        photobooth = Photobooth.find(id)
        photobooth.update_attributes(attrs)
      end

      def get_photo_by_photobooth_id(id)
        ar_photo = Photo.where(:photobooth_id => id).first
        StyleMe::Photo.new(ar_photo.attributes)
        ar_photo
      end

      def create_result(attrs)
        ar_result = Result.create(attrs)
        StyleMe::Result.new(ar_result.attributes)
      end

      def get_result(id)
        # result = StyleMe::Result.new(Result.find(id).attributes)
        Result.find(id)
      end

      def get_result_by_photobooth(photobooth_id)
        ar_result = Result.where(:photobooth_id => photobooth_id)
        ar_result.each do |result|
          StyleMe::Result.new(result.attributes)
        end
        ar_result
      end
    end
  end
end
