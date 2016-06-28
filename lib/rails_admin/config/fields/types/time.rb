require 'rails_admin/config/fields/types/datetime'

module RailsAdmin
  module Config
    module Fields
      module Types
        class Time < RailsAdmin::Config::Fields::Types::Datetime
          RailsAdmin::Config::Fields::Types.register(self)

          def parse_value(value)
            parent_value = super(value)
            return unless parent_value
            value_with_tz = parent_value.in_time_zone
            ::DateTime.parse(value_with_tz.strftime('%Y-%m-%d %H:%M:%S'))
          end

          register_instance_option :time_format do
            :time
          end

          register_instance_option :strftime_format do
            begin
              ::I18n.t(time_format, scope: i18n_scope, raise: true)
            rescue ::I18n::ArgumentError
              '%H:%M'
            end
          end
        end
      end
    end
  end
end
