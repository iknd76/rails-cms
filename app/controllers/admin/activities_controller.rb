# frozen_string_literal: true

module Admin
  class ActivitiesController < Admin::BaseController
    def index
      authorize(Activity)
      activities = Activity.
                   includes(:trackable, :user).
                   matching(params[:query]).
                   by_user(params[:user_id]).
                   order(id: :desc)
      @pagy, @activities = pagy(activities)
    end
  end
end
