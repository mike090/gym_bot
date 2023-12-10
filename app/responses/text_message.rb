# frozen_string_literal: true

module Responses
  class TextMessage < Base
    def initialize(message, **options)
      super()
      @message = message
      @options = options
    end

    def post(bot, **options)
      bot.send_message(text: @message, **options.merge(@options))
    end
  end
end
