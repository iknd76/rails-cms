# frozen_string_literal: true

module Admin
  class UsersController < Admin::BaseController
    before_action :authorize_resource_access, only: %i[index new create]
    before_action :set_user, only: %i[show edit update destroy]

    def index
      users = User.matching(params[:query]).with_role(params[:role]).order(:first_name, :last_name, :id)
      @pagy, @users = pagy(users)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        track_activity @user
        redirect_to admin_user_url(@user), notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @user.update(user_params)
        track_activity @user
        redirect_to admin_user_url(@user), notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      track_activity @user
      redirect_to admin_users_url, notice: t(".success")
    end

    private

    def authorize_resource_access
      authorize(User)
    end

    def set_breadcrumbs
      add_breadcrumb("Users", admin_users_path)
    end

    def set_user
      @user = User.find(params[:id])
      authorize(@user)
      add_breadcrumb(@user.name, admin_user_path(@user))
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :time_zone, :password, :password_confirmation, :role)
    end
  end
end
