# frozen_string_literal: true

require_relative 'boot'

Bundler.require(*GymBot.groups)

require 'singleton'
require 'telegram/bot'

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

    def logger
      @logger ||= Logger.new($stdout, Logger::DEBUG)
    end
  end

  class Application
    include Singleton
    include ActiveSupport::Configurable

    def run
      trap(:INT) { client.stop }

      client.listen do |message|
        engine.call RequestContext.new(message)
      end
    end

    private

    def client
      @client ||= begin
        token = ENV.fetch('TELEGRAM_TOKEN', nil)
        raise 'no TELEGRAM_TOKEN provided. See https://core.telegram.org/bots#how-do-i-create-a-bot' unless token

        Telegram::Bot::Client.new(token, logger: GymBot.logger)
      end
    end

    def engine
      bot = client.api
      @engine ||= Rack::Builder.app do
        use Handlers::BanBots
        use Handlers::Responder, bot
        use Handlers::Registrator
        run Handlers::Dummy.new
      end
    end
  end
end
