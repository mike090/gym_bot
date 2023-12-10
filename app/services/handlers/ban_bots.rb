# frozen_string_literal: true

module Handlers
  class BanBots
    def initialize(app)
      @app = app
    end

    def call(context)
      if context.message.from.is_bot
        context.response << Responses::TextMessage.new('Ботами не обслуживаются! Заблокирую при следующем обращении!')
      else
        @app&.call(context)
      end
    end
  end
end
