# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
ENV['RAILS_ENV'] ||= 'development'

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'active_support'

module GymBot
  class << self
    def env
      @env ||= ActiveSupport::StringInquirer.new(
        ENV.fetch('RAILS_ENV')
      )
    end

    def groups
      [:default, env.to_sym]
    end
  end
end
