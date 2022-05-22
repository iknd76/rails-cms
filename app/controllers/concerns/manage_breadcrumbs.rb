# frozen_string_literal: true

module ManageBreadcrumbs
  extend ActiveSupport::Concern

  included do
    helper_method :breadcrumbs
    before_action :set_breadcrumbs
  end

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumb(name, path)
    breadcrumbs << Breadcrumb.new(name, path)
  end

  def set_breadcrumbs; end
end
