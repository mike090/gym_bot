# frozen_string_literal: true

class RequestContext
  attr_reader :message, :response

  def initialize(message)
    @message = message
  end
end
