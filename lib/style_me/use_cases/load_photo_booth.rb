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
          "X-Mashape-Authorization" => ENV["NEW_CAMFIND_KEY"]
        }
      )
       puts "STATUS:"
       puts @response.body["status"]
      # if response is still pending, redo this job later
      # otherwise, update photobooth

      # logger.debug "#{@response}"

      @photobooth = StyleMe.db.get_photobooth(params[:photobooth_id])
      @photobooth.tags = @response.body["name"]
      # this will break when you run your test since
      # in memory db returns an entity which doesn't have .save method

      # @photobooth.save
      # OR
      # StyleMe.db.update_photobooth(@photobooth.id, { tags: @photobooth.tags }, "NA")

      puts "photobooth tags"
      puts @photobooth.tags



      #Amazon Product Market API
      if @photobooth.tags != nil
        amazon_results = get_amazon_results
        @photobooth.save
      end
      success :search_results => amazon_results, :photobooth => @photobooth
    end

    def get_amazon_results
       Amazon::Ecs.options = {
        :associate_tag => 'sty09-20',
        :AWS_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :AWS_secret_key => ENV['AWS_SECRET_ACCESS_KEY']
      }
      res =  Amazon::Ecs.item_search(@photobooth.tags, :search_index => 'Apparel')
      newray = []
      newray2 = []
      newray3 = []
      #Item Description
      res.items.each{|item| newray.push(item.get('ItemAttributes'))}
      #Item URL
      res.items.each{|item| newray3.push(item.get_hash["DetailPageURL"])}
      image_data = Amazon::Ecs.item_search(@photobooth.tags, :search_index => 'Apparel', :response_group => "Images")
      #Image URL
      image_data.items.each {|item| newray2.push(item.get_hash["LargeImage"])}
      parsed_urls = []
      parsed_descriptions = []
      parsed_shopping = []
      first_ten_descriptions = newray[0..10]
      first_ten_urls = newray2[0..10]
      first_ten_shopping = newray3[0..10]



      first_ten_urls.each do |urls|
        5.times{urls[0] = ""}
        symbol = urls.index('<')
        parsed_urls.push(urls[0..(symbol-1)])
      end

      first_ten_descriptions.each do |descriptions|
        43.times{descriptions[0] = ""}
        symbol = descriptions.index('<')
        parsed_descriptions.push(descriptions[0..(symbol-1)])
      end



      # first_ten_urls.each do |urls|
      #   5.times{urls[0] = ""}
      #   symbol = urls.index('<')
      #   urls.slice(symbol, 1000)
      # end

      # binding.pry

      parsed_descriptions.each_with_index do |description, i|
          StyleMe.db.create_result(:description => description, :url => parsed_urls[i], :shopping_url => first_ten_shopping[i], :photobooth_id => @photobooth.id)
      end

      results = StyleMe.db.get_result_by_photobooth(@photobooth.id)
      puts "RESULTS HERE 123: "
      puts results
      puts "REAL RESULTS HERE:"
      puts newray2
      results
    end
  end
end
