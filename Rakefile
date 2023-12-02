# frozen_string_literal: true

require 'bundler/setup'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :environment do
  ENV['ENVIRONMENT'] ||= 'development'
  require File.expand_path('config/environment', __dir__)
end

desc 'Run console'
task console: :environment do
  ARGV.clear
  require 'irb'
  IRB.start(__FILE__)
end

desc 'Start bot'
task start: :environment do
  GymBot.start
end

task default: %i[rubocop spec]
