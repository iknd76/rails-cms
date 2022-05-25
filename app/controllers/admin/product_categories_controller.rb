# frozen_string_literal: true

module Admin
  class ProductCategoriesController < Admin::BaseController
    before_action :authorize_resource_access, only: %i[index new create]
    before_action :set_product_category, only: %i[show edit update destroy]
    before_action :set_parent_categories, only: %i[new create edit update]

    def index
      @product_categories = ProductCategory.roots
    end

    def new
      @product_category = ProductCategory.new
    end

    def create
      @product_category = ProductCategory.new(product_category_params)
      if @product_category.save
        track_activity @product_category
        redirect_to [:admin, @product_category], notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @product_category.update(product_category_params)
        track_activity @product_category
        redirect_to [:admin, @product_category], notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product_category.destroy
      track_activity @product_category
      redirect_to admin_product_categories_url, notice: t(".success")
    end

    private

    def authorize_resource_access
      authorize(ProductCategory)
    end

    def set_breadcrumbs
      add_breadcrumb("Product categories", admin_product_categories_path)
    end

    def set_product_category
      @product_category = ProductCategory.find(params[:id])
      authorize(@product_category)
      add_breadcrumb(@product_category.name, admin_product_category_path(@product_category))
    end

    def set_parent_categories
      @parent_categories = ProductCategory.roots.excluding(@product_category)
    end

    def product_category_params
      attributes = %i[name_en name_el parent_id]
      attributes.push(:slug) if Current.user.admin?
      params.require(:product_category).permit(*attributes)
    end
  end
end
