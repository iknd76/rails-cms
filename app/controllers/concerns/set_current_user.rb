# frozen_string_literal: true

module SetCurrentUser
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  def set_current_user
    user_token = session[:user_token]
    return if user_token.blank?

    user = User.not_banned.find_by(token: user_token)
    if user
      Current.user = user
    else
      session.delete(:user_token)
    end
  end
end
