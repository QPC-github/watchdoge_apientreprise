source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use Puma as the app server
gem 'puma', '~> 3.7'

gem 'colorize'
gem 'elasticsearch'
gem 'haml'
gem 'httparty'
gem 'listen', '>= 3.0.5', '< 3.2'
gem 'pg'
gem 'sinatra', require: nil
gem 'validates_timeliness'
gem 'whenever'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'fuubar'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'mina'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'unindent'

  # ruby syntax analyze
  gem 'rubocop', require: false
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'rubocop-rspec', require: false

  gem 'mina-whenever'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :test do
  gem 'json-schema'
  gem 'rspec-its'
  gem 'rspec-json_expectations'
  gem 'rspec-rails', '~> 3.5'
  gem 'vcr'
  gem 'webmock'
  # gem 'factory_girl_rails', '~> 4.0'
  # gem 'shoulda-matchers', '~> 3.1'
  # gem 'faker'
  # gem 'database_cleaner'
end
