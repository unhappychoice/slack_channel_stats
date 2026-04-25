# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in circle.gemspec
gemspec

# io-event 1.14.4+ requires Ruby >= 3.3, but our gemspec
# (and CI matrix) supports Ruby 3.2. Cap until we drop 3.2.
gem 'io-event', '< 1.14.4'
