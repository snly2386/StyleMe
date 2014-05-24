
class PhotoboothsController < ApplicationController

  def index
      @user = StyleMe.db.get_user(params[:user_id])
      @username = @user.username
      @photobooths = StyleMe.db.get_all_photobooths_by_user_id(params[:user_id])
      @results = []
      @photobooths.each do |photobooth| 
        @results.push(StyleMe.db.get_result_by_photobooth(photobooth.id))
      end
      @originals = []
      @photobooths.each do |photobooth|
        @originals.push(photobooth.images)
      end
    
  end

  def create
    
    result = StyleMe::CreatePhotoBooth.run(:file_name => params[:file_name], :user_id => params[:user_id])  
    @result = result.results.inspect
    @description = result.description
    @photobooth = result.photobooth
    @file = result.file_name

    if params[:user_id] != nil
      @user = StyleMe.db.get_user(params[:user_id])
    end

  
    # respond_to do |format|
    #   format.js do
    #   end
    #   format.html do

    #   end
    # end


    if params[:user_id] == nil && result.success?
      redirect_to "/results/#{result.photobooth.id}"
    elsif result.success?
      redirect_to "/users/#{@user.id}/photobooths/#{result.photobooth.id}"
    else

      @error = result.error
    end
  end

  def show
    # @photobooth = StyleMe.db.get_photobooth(params[:id])
    @user = StyleMe.db.get_user(params[:user_id])
    @username = @user.username
    @photobooth = StyleMe.db.get_photobooth(params[:id])
    @original_photo = @photobooth.images
    @search_results = StyleMe.db.get_result_by_photobooth(@photobooth.id)
    @description = @photobooth.tags

    respond_to do |format|
      format.html
      format.json {render :json => {:description => @description}}
    end
   end

  def results
    # render json: StyleMe.db.get_photobooth(params[:id])

    @photobooth = StyleMe.db.get_photobooth(params[:id])
    @original_photo = @photobooth.images
    @search_results = StyleMe.db.get_result_by_photobooth(@photobooth.id)
    @description = @photobooth.tags
    photo = StyleMe.db.get_photo_by_photobooth_id(params[:id])
    @photo_path = photo.file_name 

    respond_to do |format|
      format.html 
      format.json {render :json => {:description => @description}}
    end
   
  end
end
