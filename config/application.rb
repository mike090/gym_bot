# frozen_string_literal: true

require_relative 'boot'

require 'active_support'
require 'singleton'

module GymBot
  class << self
    def application
      Application.instance
    end

    def env
      Application.config.env
    end

    def root
      Application.config.root
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
