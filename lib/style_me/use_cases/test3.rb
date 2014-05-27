require 'amazon/ecs'
require 'dotenv'

 Dotenv.load


Amazon::Ecs.options = {
  :associate_tag => 'sty09-20',
  :AWS_access_key_id => ENV['AWS_ACCESS_KEY_ID'],       
  :AWS_secret_key => ENV['AWS_SECRET_ACCESS_KEY']
}

res = Amazon::Ecs.item_search('blazer', :search_index => 'Apparel', :response_group => "Images")
# res.total_results


# res.items.each do |item|
#   item_attributes = item.get_element('ItemAttributes')
#   item_attributes.get('Title')
# end
puts "ACCESS KEYS!"
puts ENV['AWS_SECRET_ACCESS_KEY']
puts ENV['AWS_ACCESS_KEY_ID']