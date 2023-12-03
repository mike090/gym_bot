# frozen_string_literal: true

class User < ApplicationRecord
  validates :telegram_id, presence: true, uniqueness: true
  validates :given_name, presence: true
end
