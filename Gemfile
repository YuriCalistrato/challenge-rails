source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.3' # Windows WorkStation without RVM
#ruby '2.6.0' # Main WorkStation
gem 'rails', '~> 5.2.2', '>= 5.2.2.1'
gem 'pg', '~> 0.21'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'annotate'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec', '~>3.8.0'
  gem 'factory_bot_rails', '~>5.0.1'
  gem 'json_spec'
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.8.2'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
