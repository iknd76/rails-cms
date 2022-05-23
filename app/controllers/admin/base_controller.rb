# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    include AuthenticateRequest
    include ExpireIdleSession
    include AuthorizeAction
    include TrackActivity
    include ManageBreadcrumbs
    layout "admin"
  end
end
