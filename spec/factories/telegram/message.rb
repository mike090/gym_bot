# frozen_string_literal: true

FactoryBot.define do
  factory :telegram_message, class: 'Telegram::Bot::Types::Message' do
    message_id { rand 10**9 }
    from { FactoryBot.build(:telegram_user) }
    date { DateTime.now.to_i }
    chat { FactoryBot.build(:telegram_chat, **from.attributes) }

    initialize_with { new(**attributes) }
  end
end
