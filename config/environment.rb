# frozen_string_literal: true

require_relative 'application'
require 'zeitwerk'

env = ENV.fetch('ENVIRONMENT', 'development')
root = Pathname(__dir__).join '..'

GymBot::Application.configure do |config|
  config.env ||= ActiveSupport::StringInquirer.new(env)
  config.root = root
end

loader = Zeitwerk::Loader.new
loader.push_dir root.join 'app/models'
loader.setup

env_config = root.join "config/environments/#{env}.rb"
require_relative env_config if env_config.exist?

Dir[root.join 'config/initializers/**/*.rb'].each { |f| require f }
