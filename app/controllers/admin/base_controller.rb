# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    include ManageBreadcrumbs
    layout "admin"
  end
end
