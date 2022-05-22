# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.standard? || user.admin?
  end

  def show?
    user.standard? || user.admin?
  end

  def create?
    user.standard? || user.admin?
  end

  def new?
    create?
  end

  def update?
    user.standard? || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.standard? || user.admin?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
