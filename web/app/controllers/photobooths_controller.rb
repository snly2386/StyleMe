class PhotoboothsController < ApplicationController
  def create
    result = StyleMe::CreatePhotoBooth.run(:file_name => params[:file_name])
    # binding.pry   
    @result = result.results.inspect
    @description = result.description
    @photobooth = result.photobooth

    # @user = result.user
    # @photo - result.photo





    if result.success?

    #   redirect_to "/users/#{@user.id}/photos/#{@photo.id}/photobooths"
    # else

      redirect_to "/results/#{result.photobooth.id}"

    else

      @error = result.error
    end
  end

  def show
    @photobooth = StyleMe.db.get_photobooth(params[:id])
    @description = @photobooth.results
  end

  def results
    # render json: StyleMe.db.get_photobooth(params[:id])
    @photobooth = StyleMe.db.get_photobooth(params[:id])
    @description = @photobooth.tags
    @content = @photobooth.content
    @images = @photobooth.images
  end
end
