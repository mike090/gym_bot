# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'
require 'spec_helper'

require File.expand_path '../config/environment', __dir__

abort('Tests are running in production mode!') if GymBot.env.production?

Dir[GymBot.root.join('spec/support/**/*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{GymBot.root}/spec/fixtures"

  # # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # # examples within a transaction, remove the following line or assign false
  # # instead of true.
  # config.use_transactional_fixtures = true

  # Load Factory Bot methods
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  # Configure Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
  end
end
