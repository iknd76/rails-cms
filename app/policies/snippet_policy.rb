# frozen_string_literal: true

class SnippetPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
