# frozen_string_literal: true

module Handlers
  class Dummy
    def initialize(app = nil)
      @app = app
    end

    def call(env)
      env.response << Responses::TextMessage.new("I d'nt know what dose '#{env.message.text}' means!")
      @app&.call
    end
  end
end
