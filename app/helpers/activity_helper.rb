# frozen_string_literal: true

module ActivityHelper
  def emoji_for(action)
    {
      create: "✅",
      update: "✏️",
      destroy: "⛔️",
      sort: "↕️"
    }.fetch(action.to_sym, "❓")
  end

  def full_activity_summary(activity)
    safe_join([linked_user(activity), verb_for(activity), resource_for(activity), linked_trackable(activity)], " ")
  end

  def short_activity_summary(activity)
    safe_join([verb_for(activity).titleize, "by", linked_user(activity)], " ")
  end

  def verb_for(activity)
    I18n.t("admin.activities.verbs.#{activity.action}")
  end

  def resource_for(activity)
    activity.trackable_type.underscore.humanize(capitalize: false)
  end

  def linked_trackable(activity)
    trackable = activity.trackable
    if trackable
      link_to(trackable, [:admin, trackable], class: "link", data: { turbo_frame: "_top" })
    else
      safe_join([trackable_name(activity), deleted_notification(activity)].compact, " ")
    end
  end

  def trackable_name(activity)
    content_tag(:strong, activity.trackable_name)
  end

  def deleted_notification(activity)
    return nil if activity.action == "destroy"

    content_tag(:em, I18n.t("admin.activities.trackable_deleted"))
  end

  def linked_user(activity)
    if activity.user_id == Current.user.id
      content_tag(:strong, "You")
    else
      user = activity.user
      link_to(user, admin_user_path(user), class: "link", data: { turbo_frame: "_top" })
    end
  end
end
