
class MisterWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false

  def perform(token, photobooth_id)
    # token = @token_response.body['token']
    logger.info "We are here:"
    logger.info "it works~"
    logger.info token

   

    StyleMe::LoadPhotoBooth.run(:token => token, :photobooth_id => photobooth_id)
    
    # @response = Unirest::get("https://camfind.p.mashape.com/image_responses/" + token,
    #   headers: { 
    #     "X-Mashape-Authorization" => 'TTAK2kZ0uKo8QLs46T5EgUA8ZInrYfuj'
    #   }
    # )
    #   # binding.pry
    # # if response is still pending, redo this job later
    # # otherwise, update photobooth
    
    # # logger.debug "#{@response}"
    # @photobooth = StyleMe.db.get_photobooth(photobooth_id)
    # @photobooth.tags = @response.body["name"]
    # # @photobooth.save
    # puts "photobooth tags"
    # puts @photobooth.tags 


    # #Amazon Product Market API
    # Amazon::Ecs.options = {
    #   :associate_tag => 'sty09-20',
    #   :AWS_access_key_id => ENV['AWS_ACCESS_KEY_ID'],       
    #   :AWS_secret_key => ENV['AWS_SECRET_ACCESS_KEY']
    # }
    # res =  Amazon::Ecs.item_search(@photobooth.tags, :search_index => 'Apparel')
    # newray = []
    # res.items.each{|item| newray.push(item.get('ItemAttributes'))}
    # @photobooth.images = Amazon::Ecs.item_search(@photobooth.tags, :search_index => 'Apparel', :response_group => "Images")
    # @photobooth.content = newray.join(" ")
    # @photobooth.save

    # puts "PHOTOBOOTH CONTENT!"
    # puts @photobooth.content


  end
end 