# frozen_string_literal: true

module Admin
  class DashboardController < Admin::BaseController
    def show
      authorize(:dashboard)
    end
  end
end
