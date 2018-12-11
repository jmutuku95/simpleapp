source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

group :development do
  gem 'listen'
  gem 'spring', '~>2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'bcrypt', '3.1.12'
gem 'bootstrap-sass', '3.3.7'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg', '~> 0.18.4'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.7'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate', '3.1.6'
gem 'will_paginate-bootstrap', '1.0.1'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'faker', '1.6.6'
  gem 'pry', '~>0.11.3'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
