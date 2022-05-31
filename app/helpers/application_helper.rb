# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def current_page_params
    request.params.slice("category_id")
  end
end
