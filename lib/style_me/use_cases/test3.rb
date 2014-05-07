require 'amazon/ecs'
require 'dotenv'

# Dotenv.load(
#   File.expand_path("../.env",  __FILE__)
# )

Amazon::Ecs.options = {
  :associate_tag => 'sty09-20',
  :AWS_access_key_id => ENV['AWS_ACCESS_KEY_ID'],       
  :AWS_secret_key => ENV['AWS_SECRET_ACCESS_KEY']
}

# res = Amazon::Ecs.item_search('ruby', :search_index => 'Apparel')
# res.total_results


# res.items.each do |item|
#   item_attributes = item.get_element('ItemAttributes')
#   item_attributes.get('Title')
# end

puts ENV['AWS_SECRET_ACCESS_KEY']
puts ENV['AWS_ACCESS_KEY_ID']