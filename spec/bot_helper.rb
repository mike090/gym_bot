# frozen_string_literal: true

require 'spec_helper'
ENV['ENIRONMENT'] ||= 'test'
require File.expand_path '../config/environment', __dir__
abort('Tests are running in production mode!') if GymBot.env.production?

Dir[GymBot.root.join('spec/support/**/*.rb')].each { |f| require f }
