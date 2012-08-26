source 'https://rubygems.org'

# rails
gem 'rails', '3.2.8'

# db
gem "mongoid", "~> 3.0.4"

# third party connect
gem "koala", "~> 1.5.0"

# application dependencies
gem 'thin'
gem "sidekiq", "~> 2.0.3"
gem 'slim'
gem 'sinatra', require: nil
gem 'jbuilder'
gem 'yajl-ruby', require: 'yajl'
gem "youtube_it", "~> 2.1.7"

# front end helpers
gem 'jquery-rails'
gem 'simple_form'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails'
end

# tests
group :test, :development do
  gem 'pry'
  gem 'minitest'
  gem 'capybara'
  gem 'database_cleaner'
  gem "turn", "~> 0.9.4"
end
