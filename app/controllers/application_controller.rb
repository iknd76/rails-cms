# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SetRequestInfo
  include SetCurrentUser
  include Pagy::Backend
end
