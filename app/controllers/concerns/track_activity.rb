# frozen_string_literal: true

module TrackActivity
  extend ActiveSupport::Concern

  def track_activity(trackable, action = params[:action])
    return if action == "update" && trackable.saved_changes.blank?

    Current.user.activities.create!(trackable:, action:)
  end
end
