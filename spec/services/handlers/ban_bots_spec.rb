# frozen_string_literal: true

require 'bot_helper'

RSpec.describe Handlers::BanBots do
  describe '#call' do
    subject(:handler) { described_class.new(app) }

    let(:context) { RequestContext.new(message).extend ResponsibleConcern }
    let(:app) { instance_spy(Proc) }
    let(:message) { build(:telegram_message, from:) }
    let(:from) { build(:telegram_user) }

    before { handler.call(context) }

    context 'when bot' do
      let(:from) { build(:telegram_user, is_bot: true) }

      it 'ansver with text message and dnt call app' do
        expect(context.response).to include Responses::TextMessage
        expect(app).not_to have_received(:call)
      end
    end

    context 'when not bot' do
      it 'dnt add message to response and call app' do
        expect(context.response).to be_empty
        expect(app).to have_received(:call).with(context)
      end
    end
  end
end
