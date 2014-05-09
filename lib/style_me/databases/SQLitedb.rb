require 'yaml'
require 'active_record'
require 'pry-debugger'
# dbconfig = YAML::load(File.open('db/config.yml'))
# ActiveRecord::Base.establish_connection(dbconfig)
module StyleMe
  module Databases

    class User < ActiveRecord::Base
      has_one :closet
    end

    class Closet < ActiveRecord::Base
      belongs_to :user
      has_many :photobooths
    end

    class Photobooth < ActiveRecord::Base
      belongs_to :photo
      has_many :results
    end

    class Photo <ActiveRecord::Base
      has_one :photobooth
    end

    class Result < ActiveRecord::Base
      belongs_to :photobooth
    end

    class SQLiteDatabase

      def initialize
        ActiveRecord::Base.establish_connection(
          :adapter => 'sqlite3',
          :database => '../StyleMe_dev'
        )
      end
      # binding.pry
      def clear_everything
        User.destroy_all
        Closet.destroy_all
        Photobooth.destroy_all
        Photo.destroy_all
        Result.destroy_all
      end


      #Database Methods
      def create_user(attrs)
        ar_user = User.create(attrs)
        StyleMe::User.new(ar_user.attributes)
      end

      def get_user(id)
        user = StyleMe::User.new(User.find(id).attributes)
        # user.closet = ...
        # user
      end

      def get_user_by_username(username)
        ar_user = User.where(:username =>username).first
        StyleMe::User.new(ar_user.attributes)
      end

      def create_session(attrs)
        ar_session = Session.create(attrs)
        StyleMe::Session.new(ar_session.attributes)
      end

      def get_session(attrs)

      end

      def create_closet(attrs)
        ar_closet = Closet.create(attrs)
        StyleMe::Closet.new(ar_closet.attributes)
      end

      def get_closet(id)
        closet = StyleMe::Closet.new(Closet.find(id).attributes)
      end

      def create_photo(attrs)
        # binding.pry
        ar_photo = Photo.create(attrs)
        StyleMe::Photo.new(ar_photo.attributes)
      end

      def get_photo(id)
        photo = StyleMe::Photo.new(Photo.find(id).attributes)
      end

      def create_photobooth(attrs)
        ar_photobooth = Photobooth.create(attrs)
        StyleMe::Photobooth.new(ar_photobooth.attributes)
      end

      def get_photobooth(id)
        photobooth = StyleMe::Databases::Photobooth.find(id)
      end



    end
  end
end
