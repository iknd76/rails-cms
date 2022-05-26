# frozen_string_literal: true

module BadgeHelper
  def badge_for(value)
    content_tag :span, value.titleize, class: "badge badge-#{value.dasherize}"
  end
end
