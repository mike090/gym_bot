# frozen_string_literal: true

require 'bot_helper'

RSpec.describe Handlers::Registrator do
  describe '#call' do
    subject(:user) { User.find_by telegram_id: from.id }

    let(:context) { RequestContext.new(message).extend ResponsibleConcern }
    let(:message) { build(:telegram_message, text: 'Hi!', from:) }
    let(:from) { build(:telegram_user) }

    context 'when new user' do
      before { described_class.new(nil).call(context) }

      it 'authenticate context' do
        expect(context.user).to eq user
      end

      it 'welcome and save user' do
        expect(context.response.first).to be_a Responses::TextMessage
        expect(user).not_to be_nil
        expect(user.telegram_id).to eq message.from.id
        expect(user.username).to eq message.from.username
        expect(user.given_name).to eq message.from.first_name
        expect(user.family_name).to eq message.from.last_name
      end
    end

    context 'when existent user' do
      before do
        create(:user, telegram_id: from.id)
        described_class.new(nil).call(context)
      end

      it 'authenticate context' do
        expect(context.user).to eq user
      end

      it 'update user data expect given and family name' do
        expect(user.username).to eq from.username
        expect(user.given_name).not_to eq(from.first_name)
        expect(user.family_name).not_to eq(from.last_name)
      end
    end
  end
end
