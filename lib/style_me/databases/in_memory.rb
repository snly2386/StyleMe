module StyleMe
  module Databases
    class InMemory

      def initialize(env= nil)
       clear_everything
      end

       def clear_everything
        @user_id_counter = 100
        @closets_id_counter = 200
        @photobooths_id_counter = 300
        @photo_id_counter = 400
        @result_id_counter = 500
        @session_id_counter = 600
        @users = {}
        @closets = {}
        @photobooths = {}
        @photos = {}
        @results = {}
        @sessions = {}

      end

      def create_user(attrs)

         id = @user_id_counter += 1
         attrs[:id] = id

        user = User.new(:id => id, :username => attrs[:username], :name => attrs[:name], :age => attrs[:age], :gender => attrs[:gender], :about_me => attrs[:about_me], :password => attrs[:password], :password_digest => attrs[:password_digest])
        @users[id] = user
      end

      def get_user(id)
        # Since everything is in one object, this might be really messy later when we add persistence
        # Or, if we choose the right database (*cough* document-oriented database *cough*) it might not!
        # (A document-oriented database might be the right choice *for this project* because there is no
        # more than one user playing the game at one time)
        @users[id]
      end

      def get_user_by_username(username)
        user = @users.select{|x,y| y.username == username }
        user.values[0]
      end


      def create_session(attrs)
        id = @session_id_counter += 1
        # binding.pry
        # attrs[:id] = id
        session = Session.new(:id => id, :user_id => attrs[:user_id])
        @sessions[id] = session
      end

      def get_session(id)
        @sessions[id]

        #returns { session_id => session}
      end

      def get_session_by_user_id(user_id)
        session = @sessions.select{|x,y| y.user_id == user_id}
        session.values[0]
      end

      def create_closet(attrs)
        id = @closets_id_counter += 1
        attrs[:id] = id
        closet = Closet.new(:id => id, :user_id => attrs[:user_id])
        @closets[id] = closet
      end

      def get_closet(id)
        @closets[id]
      end

      def create_photo(attrs)
        id = @photo_id_counter += 1
        attrs[:id] = id
        photo = Photo.new(:id => id, :url => attrs[:url])
        @photos[photo.id] = photo
      end

      def get_photo(id)
        @photos[id]
      end

      def create_photobooth(attrs)
        id = @photobooths_id_counter += 1
        attrs[:id] = id
        photobooth = Photobooth.new(:id => id, :closet_id => attrs[:closet_id], :photo_id => attrs[:photo_id])
        @photobooths[id] = photobooth
      end

      def get_photobooth(id)
        @photobooths[id]
      end

      def create_result(attrs)
        id = @result_id_counter += 1
        attrs[:id] = id
        result = Result.new(:id => id, :photobooth_id => attrs[:photobooth_id])
        @results[id] = result
      end

      def get_result(id)
        @results[id]
      end

    end
  end
end
