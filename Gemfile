# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# gem "rails"

# web framework
gem 'sinatra'

# database ORM
gem 'sinatra-activerecord'
# postgres client
gem 'pg'

# task automation
gem 'rake'

# command pattern
gem 'trailblazer'

# console
gem 'irb', require: false

group :test, :development do
  # debugging
  gem 'byebug'

  # http client
  gem 'httparty'
  gem 'rack-test'
  gem 'rspec'
  gem 'database_cleaner-active_record'
end