# frozen_string_literal: true

module Admin
  class ProfilesController < Admin::BaseController
    before_action :set_user

    def show; end

    def update
      if @user.update_with_password(profile_params)
        refresh_session_token
        redirect_to admin_profile_path, notice: t(".success")
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def profile_params
      params.require(:user).permit(:first_name, :last_name, :email, :time_zone, :current_password, :password, :password_confirmation)
    end

    def refresh_session_token
      session[:user_token] = @user.token
    end

    def set_breadcrumbs
      add_breadcrumb("Profile", admin_profile_path)
    end

    def set_user
      @user = Current.user
      authorize(@user, policy_class: ProfilePolicy)
    end
  end
end
