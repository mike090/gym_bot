# frozen_string_literal: true

class BotEngine
  def initialize(bot)
    @bot = bot
  end

  def handle(message)
    GymBot.logger.info("Received `#{message.text}` from @#{message.from.username}.")
    response = Handlers::DummyHandler.new.handle(message)
    response.send(@bot, chat_id: message.from.id)
  end
end
