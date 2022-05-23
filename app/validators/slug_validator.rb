# frozen_string_literal: true

class SlugValidator < ActiveModel::EachValidator
  SLUG_REGEXP = /\A[a-z0-9\-]+\z/

  def validate_each(record, attribute, value)
    record.errors.add attribute, :invalid unless valid?(value)
  end

  def valid?(value)
    SLUG_REGEXP.match?(value)
  end
end
