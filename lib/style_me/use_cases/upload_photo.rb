
module StyleMe
  class UploadPhoto < UseCase
    def run(params)
      @db = StyleMe.db
      url = params[:url]
      return failure(:invalid_url) if url.empty?


      photo = @db.create_photo(:url => params[:url])

      

      success :photo => photo
    end
  end
end