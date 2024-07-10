# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.3.3"

gem "bootsnap", require: false
gem "importmap-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"
gem "redis", ">= 4.0.1"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]

# Needed until Ruby 3.3.4 is released https://github.com/ruby/ruby/pull/11006
gem "net-pop", github: "ruby/net-pop"

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails"
  gem "rubocop-rspec"
  gem "rubocop-rspec_rails"
end

group :development do
  gem "dockerfile-rails", ">= 1.6"
  gem "rubocop"
  gem "rubocop-rails"
  gem "web-console"
end
