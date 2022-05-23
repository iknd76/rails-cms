# frozen_string_literal: true

class ActivityPolicy < ApplicationPolicy
  def index?
    user.admin?
  end
end
