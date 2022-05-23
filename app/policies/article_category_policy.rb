# frozen_string_literal: true

class ArticleCategoryPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def sort?
    update?
  end

  def destroy?
    user.admin?
  end
end
