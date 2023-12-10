# frozen_string_literal: true

FactoryBot.define do
  factory :telegram_chat, class: 'Telegram::Bot::Types::Chat' do
    id { rand(10**9) }
    type { 'private' }

    initialize_with { new(**attributes) }
  end
end
