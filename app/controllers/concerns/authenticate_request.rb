# frozen_string_literal: true

module AuthenticateRequest
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  def authenticate_request
    redirect_to login_url, alert: t("auth.flash.unauthenticated") unless Current.user
  end
end
