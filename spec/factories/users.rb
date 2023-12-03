# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    telegram_id { rand(10**9) }
    given_name { Faker::Name.first_name }
    family_name { Faker::Name.last_name }
    username { Faker::Internet.username }
  end
end
