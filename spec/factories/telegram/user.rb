# frozen_string_literal: true

FactoryBot.define do
  factory :telegram_user, class: 'Telegram::Bot::Types::User' do
    id { rand(10**9) }
    is_bot { false }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username }

    initialize_with { new(**attributes) }
  end
end
