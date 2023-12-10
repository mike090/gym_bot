# frozen_string_literal: true

require 'bot_helper'

RSpec.describe Handlers::Responder do
  describe '#call' do
    subject(:handler) { described_class.new app, 'bot' }

    let(:first_message) { instance_spy Responses::TextMessage }
    let(:second_message) { instance_spy Responses::TextMessage }
    let(:message) { build(:telegram_message) }
    let(:app) { ->(env) { env.response << first_message << second_message } }

    it 'sends messages in the order they were added' do
      handler.call(RequestContext.new(message))
      expect(first_message).to have_received(:post).with('bot', chat_id: message.chat.id).ordered
      expect(second_message).to have_received(:post).with('bot', chat_id: message.chat.id).ordered
    end
  end
end
