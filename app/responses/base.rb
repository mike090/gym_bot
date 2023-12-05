# frozen_string_literal: true

module Responses
  class Base
    def send(_bot, **_options)
      rase NotImplementedError
    end
  end
end
