source 'https://rubygems.org'

ruby '2.4.2'
gem 'rails', '5.1.4'

# these Gems are first so Carrierwave doesn't load all of the other fog providers
gem 'fog-aws' # for Carrierwave
gem 'carrierwave', '1.1.0' # for file uploads

gem 'devise', '4.3.0' # authentication
gem 'omniauth-google-oauth2' # for Google account access
gem 'paper_trail', '7.0.3' # auditing and versioning
gem 'pg', '0.20.0' # for Postgres
gem 'pg_search', '2.1.1' # full-text search for Postgres
gem 'puma', '3.11.0' # web server
gem 'pundit', '1.1.0' # authorization
gem 'rack-cors' # for CORS support
gem 'rack-timeout', '0.4.2' # end requests that take too long
gem 'redis', '3.3.3' # for Action Cable and Sidekiq
gem 'sass-rails', '5.0.6' # for SCSS files
gem 'sidekiq', '5.0.3' # background jobs
gem 'simple_form', '3.5.0' # rails forms made easier
gem 'slim-rails', '3.1.0' # lightweight HTML templating language, replacing ERB or Haml
gem 'turbolinks', '5.0.0' # makes navigating your web application faster
gem 'twilio-ruby', '4.13.0' # our bridge to telephony
gem 'uglifier', '3.0.0' # compressor for JavaScript assets

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-jquery-ujs'
  gem 'rails-assets-jquery'
  gem 'rails-assets-circliful'
end

group :development, :test do
  gem 'factory_girl_rails', '4.7.0'
  gem 'faker', '1.6.5'
  gem 'rspec-rails', '3.5.1'
end

group :development do
  gem 'annotate', '2.7.1'
  gem 'byebug', platform: :mri # for debugging
  gem 'dotenv-rails'
  gem 'listen', '~> 3.0.5'
  gem 'spring' # speeds up development by keeping the app running in the background
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console' # access an IRB console on exception pages
end
