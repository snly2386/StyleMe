require 'style_me' # for some reason this works in rspec
require 'pry-debugger'
require_relative 'shared/database_spec.rb'

require 'vcr'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  StyleMe.db_class = StyleMe::Databases::InMemory

  config.before(:each) do
    StyleMe.instance_variable_set(:@__db_instance, nil)
    StyleMe.db.clear_everything
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end
