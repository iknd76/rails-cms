# frozen_string_literal: true

module Admin
  class SortablesController < Admin::BaseController
    def create
      @record = GlobalID::Locator.locate_signed(params[:sgid])
      authorize(@record, :sort?)
      @record.insert_at(params[:position].to_i)
      track_activity @record, :sort
      head :ok
    end
  end
end
