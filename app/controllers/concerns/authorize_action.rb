# frozen_string_literal: true

module AuthorizeAction
  extend ActiveSupport::Concern
  include Pundit::Authorization

  included do
    after_action :verify_authorized
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  def pundit_user
    Current.user
  end

  def user_not_authorized
    redirect_back_or_to admin_root_url, allow_other_host: false, alert: t("auth.flash.unauthorized")
  end
end
