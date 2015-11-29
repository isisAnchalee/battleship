source 'https://rubygems.org'

ruby '2.2.1'

gem 'rails', '4.2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'haml'
gem 'unicorn'
gem 'turbolinks'
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'font-awesome-rails'
gem 'kaminari'
gem 'poltergeist'

group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
end

group :development, :test do
  gem 'faker'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'annotate'
  gem 'capybara'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'sqlite3',     '1.3.9'
  gem 'byebug',      '3.4.0'
  gem 'pry'
  gem 'rspec-rails', '~> 3.0'
end

group :test do
  gem "shoulda-matchers", "< 3.0.0",
    require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

