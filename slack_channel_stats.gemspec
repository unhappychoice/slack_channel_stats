# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_channel_stats/version'

def production_dependency(spec)
  spec.add_dependency 'slack-ruby-client'
  spec.add_dependency "tty-box", "~> 0.4.1"
  spec.add_dependency "tty-color", "~> 0.5"
  spec.add_dependency "tty-command", "~> 0.9.0"
  spec.add_dependency "tty-config", ">= 0.3.2", "< 0.7.0"
  spec.add_dependency "tty-cursor", "~> 0.7"
  spec.add_dependency "tty-editor", "~> 0.5"
  spec.add_dependency "tty-file", ">= 0.8", "< 0.11"
  spec.add_dependency "tty-font", "~> 0.4.0"
  spec.add_dependency "tty-logger", "~> 0.2.0"
  spec.add_dependency "tty-markdown", "~> 0.6.0"
  spec.add_dependency "tty-pager", "~> 0.12"
  spec.add_dependency "tty-pie", "~> 0.3.0"
  spec.add_dependency "tty-platform", "~> 0.2"
  spec.add_dependency "tty-progressbar", "~> 0.17"
  spec.add_dependency "tty-prompt", "~> 0.19"
  spec.add_dependency "tty-screen", "~> 0.7"
  spec.add_dependency "tty-spinner", "~> 0.9"
  spec.add_dependency "tty-table", "~> 0.11.0"
  spec.add_dependency "tty-tree", "~> 0.3"
  spec.add_dependency "tty-which", "~> 0.4"
  spec.add_dependency "pastel", "~> 0.7.2"
  spec.add_dependency "thor", "~> 0.20.0"
end

def development_dependency(spec)
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'codecov'
  spec.add_development_dependency 'github_changelog_generator'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
end

def project_files
  `git ls-files -z`
    .split("\x0")
    .reject { |f| f.match(%r{^(test|spec|features)/}) }
end

Gem::Specification.new do |spec|
  spec.name          = 'slack_channel_stats'
  spec.version       = SlackChannelStats::VERSION
  spec.required_ruby_version = '>= 2.5'
  spec.authors       = ['unhappychoice']
  spec.email         = ['unhappychoice@gmail.com']

  spec.summary       = 'CLI tool to summarize slack channel stats'
  spec.description   = 'CLI tool to summarize slack channel stats'
  spec.homepage      = 'https://github.com/unhappychoice/slack_channel_stats'
  spec.license       = 'MIT'
  spec.files         = project_files
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  production_dependency spec
  development_dependency spec
end
