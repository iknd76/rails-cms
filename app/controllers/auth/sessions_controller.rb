# frozen_string_literal: true

module Auth
  class SessionsController < Auth::BaseController
    def new; end

    def create
      user = User.authenticate(login_params)
      if user
        log_in user
        redirect_to admin_root_url, notice: t("auth.flash.logged_in", name: user.name.first)
      else
        flash.now[:alert] = t("auth.flash.invalid_credentials")
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      reset_session
      redirect_to root_url, notice: t("auth.flash.logged_out")
    end

    private

    def log_in(user)
      reset_session
      session[:user_token] = user.token
      session[:expires_at] = 30.minutes.from_now
    end

    def login_params
      params.require(:session).permit(:email, :password)
    end
  end
end
