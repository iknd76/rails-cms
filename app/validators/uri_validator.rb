# frozen_string_literal: true

class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, :invalid unless valid?(value)
  end

  def valid?(value)
    uri = URI.parse(value)
    %w[http https].include?(uri.scheme)
  rescue URI::InvalidURIError, URI::InvalidComponentError
    false
  end
end
