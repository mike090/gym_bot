# frozen_string_literal: true

require 'bot_helper'

RSpec.describe User, type: :model do
  subject(:user) { create :user }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:given_name) }
    it { is_expected.to validate_uniqueness_of(:telegram_id) }
    it { is_expected.to validate_presence_of(:telegram_id) }
  end
end
