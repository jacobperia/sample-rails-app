# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use postgresql as the database for Active Record
gem 'pg'

# Use Puma as the app server
gem 'puma'

# Use SCSS for stylesheets
gem 'sass-rails'
gem 'webpacker'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap'

# Use Redis adapter to run Action Cable in production
gem 'redis'

# Front-end
# seem to need bootstrap gem for dropdown styles to work correctly.
# Something isn't loading from node_modules maybe?
gem 'bootstrap', '~> 5.1.3'

gem 'haml-rails'
gem 'simple_form'

gem 'high_voltage'
gem 'meta-tags'

gem 'stimulus-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# User auth
gem 'devise'
gem 'pundit'

# User impersonation
gem "pretender"

# Security
gem 'hashid-rails', '~> 1.0'

# Backend helpers
gem 'active_record_union'
gem 'chronic'
gem 'discard', '~> 1.2'
gem 'kaminari'
gem 'paper_trail'
gem 'timecop'
gem 'friendly_id', '~> 5.4.0'

# Mailchimp list sync
gem 'gibbon'

gem 'sidekiq'

# Payments
gem 'stripe'
gem 'stripe_event'

# Intercom
gem 'intercom-rails'

# Development
gem 'annotate'
gem 'raygun4ruby'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rb-readline'

  # for loading values from application.yml locally
  gem 'figaro'

  # Automated testing
  gem 'capybara'
  gem 'capybara-selenium'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pundit-matchers', '~> 1.7.0', require: false
  gem 'rspec-rails'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'stripe-ruby-mock', '~> 3.1.0.rc2', require: 'stripe_mock'
end

group :development do
  gem "rails_live_reload"
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'

  # To alert for N + 1 queries
  gem 'bullet'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'guard'
  # gem 'guard-livereload', require: false
  # gem 'rack-livereload'

  gem 'brakeman', require: false
  gem 'rubocop', require: false

  gem 'letter_opener'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
