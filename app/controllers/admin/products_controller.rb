# frozen_string_literal: true

module Admin
  class ProductsController < Admin::BaseController
    before_action :authorize_resource_access, only: %i[index new create]
    before_action :set_product, only: %i[show edit update destroy]

    def index
      products = Product.
                 includes(:product_category, :supplier).
                 matching(params[:query]).
                 in_category(params[:category_id]).
                 by_supplier(params[:supplier_id]).
                 with_status(params[:status]).
                 order(id: :desc)
      @pagy, @products = pagy(products)
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        track_activity @product
        redirect_to [:admin, @product], notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @product.update(product_params)
        track_activity @product
        redirect_to [:admin, @product], notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy
      track_activity @product
      redirect_to admin_products_url, notice: t(".success")
    end

    private

    def authorize_resource_access
      authorize(Product)
    end

    def set_breadcrumbs
      add_breadcrumb("Products", admin_products_path)
    end

    def set_product
      @product = Product.find(params[:id])
      authorize(@product)
      add_breadcrumb(@product.title, admin_product_path(@product))
    end

    def product_params
      params.require(:product).permit(:product_category_id, :supplier_id, :title_en, :title_el, :body_en, :body_el, :status, :published_on)
    end
  end
end
