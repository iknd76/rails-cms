# frozen_string_literal: true

class TimeZoneValidator < ActiveModel::EachValidator
  TIME_ZONE_NAMES = ActiveSupport::TimeZone.all.map(&:name)

  def validate_each(record, attribute, value)
    record.errors.add attribute, :inclusion unless valid?(value)
  end

  def valid?(value)
    TIME_ZONE_NAMES.include?(value)
  end
end
