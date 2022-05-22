# frozen_string_literal: true

module ExpireIdleSession
  extend ActiveSupport::Concern

  included do
    before_action :expire_idle_session
  end

  def expire_idle_session
    expires_at = session[:expires_at]
    if expires_at && expires_at < Time.current
      redirect_to login_url, alert: t("auth.flash.session_expired")
    else
      session[:expires_at] = 30.minutes.from_now
    end
  end
end
