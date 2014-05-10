require '../lib/style_me.rb'

StyleMe.db_class = StyleMe::Databases::SQLiteDatabase
StyleMe.env = 'development'
StyleMe.db_seed

