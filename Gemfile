source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.4"
gem "puma", "~> 5.0"
gem 'mysql2', '>= 0.5.4'
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'enumerize', '~> 2.3', '>= 2.3.1'
gem 'devise'
gem 'devise_token_auth'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'kaminari'
gem 'omniauth'
gem 'slim-rails'
gem 'active_model_serializers'
gem 'active_hash'
gem 'discard', '~> 1.2'
gem 'paper_trail'
gem 'paper_trail-association_tracking'
gem 'ransack'
gem 'aws-sdk-rails', '~> 3'
gem 'aws-sdk-s3', '~> 1'
gem 'lockbox'
gem 'config'
gem 'factory_bot_rails'
gem 'draper'
gem 'pry-rails'
gem 'rack-cors'
gem 'faker'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i(mri mingw x64_mingw)
  gem 'rubocop', '~> 1.36', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rails_best_practices'
  gem 'brakeman'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'letter_opener_web'
  gem 'listen', '~> 3.3'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'rspec-rails', '~> 4.0.1'
  gem 'rspec_junit_formatter'
  gem "rspec-sidekiq"
  gem "rails-controller-testing"
end
