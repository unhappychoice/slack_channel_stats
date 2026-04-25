# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in circle.gemspec
gemspec

# Ruby 3.2 support: cap async-stack gems whose latest releases
# have bumped required_ruby_version past 3.2.
gem 'async', '< 2.38'         # 2.38+ requires Ruby >= 3.3
gem 'io-event', '< 1.14.4'    # 1.14.4+ requires Ruby >= 3.3
