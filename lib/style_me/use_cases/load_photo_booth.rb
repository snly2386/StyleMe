require 'dotenv'
Dotenv.load 
require 'unirest'

module StyleMe
  class LoadPhotoBooth < UseCase 
    def run(params)

      puts "AMAZON KEYS:"
      puts ENV['AWS_ACCESS_KEY_ID']
      puts ENV['AWS_SECRET_ACCESS_KEY']
      puts "USING TEKON: #{params[:token]}"

     @response = Unirest::get("https://camfind.p.mashape.com/image_responses/" + params[:token],
      headers: { 
        "X-Mashape-Authorization" => 'TTAK2kZ0uKo8QLs46T5EgUA8ZInrYfuj'
      }
    )
      # binding.pry
    # if response is still pending, redo this job later
    # otherwise, update photobooth
    
    # logger.debug "#{@response}"
    @photobooth = StyleMe.db.get_photobooth(params[:photobooth_id])
    @photobooth.tags = @response.body["name"]
    # @photobooth.save
    puts "photobooth tags"
    puts @photobooth.tags 



    #Amazon Product Market API
    Amazon::Ecs.options = {
      :associate_tag => 'sty09-20',
      :AWS_access_key_id => ENV['AWS_ACCESS_KEY_ID'],       
      :AWS_secret_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
    res =  Amazon::Ecs.item_search(@photobooth.tags, :search_index => 'Apparel')
    newray = []
    res.items.each{|item| newray.push(item.get('ItemAttributes'))}
    image_data = Amazon::Ecs.item_search(@photobooth.tags, :search_index => 'Apparel', :response_group => "Images")
    newray2 = []
    image_data.items.each {|item| newray2.push(item.get_hash["DetailPageURL"])}
    

    # @photobooth.content = newray.join(" ")
    # @photobooth.images = newray2.join(" ")
    # @photobooth.save
    newray.each do |description| 
      newray2.each do |url| 
        StyleMe.db.create_result(:description => description, :url => url, :photobooth_id => @photobooth.id)
      end
    end

    results = StyleMe.db.get_result_by_photobooth(@photobooth.id)



    success :search_results => results, :photobooth => @photobooth
    end
  end



end