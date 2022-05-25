# frozen_string_literal: true

class ProductCategoryPolicy < ApplicationPolicy
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
