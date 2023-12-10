# frozen_string_literal: true

module Handlers
  class Registrator
    USER_ATTRS_MAP = { telegram_id: :id, given_name: :first_name, family_name: :last_name,
                       username: :username }.freeze
    KEEP_DATA = %i[given_name family_name].freeze

    def initialize(app)
      @app = app
    end

    def call(context)
      @context = context
      @context.extend AuthenticationConcern
      @context.user = User.find_or_initialize_by(telegram_id: @context.message.from.id)
      welcome_new_user if @context.user.new_record?
      update_user(**context.message.from.attributes)
      @app&.call(context)
    end

    private

    def welcome_new_user
      @context.response << Responses::TextMessage.new('Привет! Я помогаю с организацией тренировок в клубе')
    end

    def update_user(**user_data)
      attrs = transform_data(user_data)
      @context.user.update attrs unless attrs.empty?
    end

    def transform_data(data)
      attrs = USER_ATTRS_MAP.transform_values { |v| data[v] }.compact
      to_update = attrs.keys - KEEP_DATA.select { |attr| @context.user[attr] }
      attrs.slice(*to_update)
    end
  end
end
