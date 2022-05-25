# frozen_string_literal: true

module Admin
  class SuppliersController < Admin::BaseController
    before_action :authorize_resource_access, only: %i[index new create]
    before_action :set_supplier, only: %i[show edit update destroy]

    def index
      suppliers = Supplier.matching(params[:query]).order(id: :desc)
      @pagy, @suppliers = pagy(suppliers)
    end

    def new
      @supplier = Supplier.new
    end

    def create
      @supplier = Supplier.new(supplier_params)
      if @supplier.save
        track_activity @supplier
        redirect_to [:admin, @supplier], notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @supplier.update(supplier_params)
        track_activity @supplier
        redirect_to [:admin, @supplier], notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @supplier.destroy
      track_activity @supplier
      redirect_to admin_suppliers_url, notice: t(".success")
    end

    private

    def authorize_resource_access
      authorize(Supplier)
    end

    def set_breadcrumbs
      add_breadcrumb("Suppliers", admin_suppliers_path)
    end

    def set_supplier
      @supplier = Supplier.find(params[:id])
      authorize(@supplier)
      add_breadcrumb(@supplier.name, admin_supplier_path(@supplier))
    end

    def supplier_params
      params.require(:supplier).permit(:name, :website, :logo)
    end
  end
end
