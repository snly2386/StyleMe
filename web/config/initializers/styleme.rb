require '../lib/style_me.rb'

StyleMe.db_class = StyleMe::Databases::PostGres
StyleMe.env = 'development'
StyleMe.db_seed

