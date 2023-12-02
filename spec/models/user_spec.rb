# frozen_string_literal: true

require 'bot_helper'

RSpec.describe User do
  it 'can be created' do
    expect(described_class.new).to_not be_nil
  end
end
