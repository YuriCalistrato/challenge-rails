# Rails Spec
require 'spec_helper'
require 'support/factory_bot'
require 'support/json_spec'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  
  # https://relishapp.com/rspec/rspec-rails/docs

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
