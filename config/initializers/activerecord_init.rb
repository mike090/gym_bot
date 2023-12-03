# frozen_string_literal: true

ActiveSupport.on_load(:active_record_postgresqladapter) do
  ActiveSupport.on_load(:active_record) do
    time_zone_aware_types << :timestamptz
  end
end

ActiveSupport.on_load(:active_record) do
  self.time_zone_aware_attributes = true
  self.configurations = GymBot::Application.config.database_configurations
  establish_connection
end
