# frozen_string_literal: true

require_relative 'application'
require 'dotenv/load'

GymBot::Application.configure do |config|
  config.database_configurations = begin
    config = GymBot.root.join 'config/database.yml'
    raise "Could not load database configuration. No such file #{config}" unless config&.exist?

    YAML.load(ERB.new(config.read).result, aliases: true) || {}
  end
end

loader = Zeitwerk::Loader.new
loader.push_dir GymBot.root.join 'app/models'
loader.push_dir GymBot.root.join 'app/services'
loader.push_dir GymBot.root.join 'app'
loader.setup

env_config = GymBot.root.join "config/environments/#{GymBot.env}.rb"
require_relative env_config if env_config.exist?

Dir[GymBot.root.join 'config/initializers/**/*.rb'].each { |f| require f }
