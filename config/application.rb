# frozen_string_literal: true

require_relative 'boot'

Bundler.require(*GymBot.groups)

require 'singleton'

module GymBot
  class << self
    def application
      Application.instance
    end

    def root
      @root ||= Pathname(__dir__).join '..'
    end

    def start
      application.run
    end
  end

  class Application
    include Singleton
    include ActiveSupport::Configurable

    def run
      puts 'Running bot...'
    end
  end
end
