# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

group :test do
  gem 'rspec'
  gem 'rspec-json_expectations'
end

group :development, :test do
  gem 'pry-byebug'
end

group :development do
  gem 'rubocop'
end

gem 'activemodel', '~> 6.1.4'
