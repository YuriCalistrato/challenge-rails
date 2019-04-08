# Adding Factory Bot Methods to RSpec
require 'factory_bot'
RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
end