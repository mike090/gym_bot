# frozen_string_literal: true

module Handlers
  class Responder
    def initialize(app, bot)
      @app = app
      @bot = bot
    end

    def call(context)
      exit unless @app

      context.extend ResponsibleConcern
      @app.call context
      context.response.each { |message| message.post(@bot, chat_id: context.message.chat.id) }
    end
  end
end
