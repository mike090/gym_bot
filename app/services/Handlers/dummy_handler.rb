# frozen_string_literal: true

module Handlers
  class DummyHandler <  Base
    def call(env)
      Responses::TextMessage.new "I d'nt know what dose '#{env.text}' means!"
    end
  end
end
