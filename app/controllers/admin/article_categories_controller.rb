# frozen_string_literal: true

module Admin
  class ArticleCategoriesController < Admin::BaseController
    before_action :authorize_resource_access, only: %i[index new create]
    before_action :set_article_category, only: %i[show edit update destroy]

    def index
      @article_categories = ArticleCategory.order(:position)
    end

    def new
      @article_category = ArticleCategory.new
    end

    def create
      @article_category = ArticleCategory.new(article_category_params)
      if @article_category.save
        track_activity @article_category
        redirect_to [:admin, @article_category], notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @article_category.update(article_category_params)
        track_activity @article_category
        redirect_to [:admin, @article_category], notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article_category.destroy
      track_activity @article_category
      redirect_to admin_article_categories_url, notice: t(".success")
    end

    private

    def authorize_resource_access
      authorize(ArticleCategory)
    end

    def set_breadcrumbs
      add_breadcrumb("Article categories", admin_article_categories_path)
    end

    def set_article_category
      @article_category = ArticleCategory.find(params[:id])
      authorize(@article_category)
      add_breadcrumb(@article_category.name, admin_article_category_path(@article_category))
    end

    def article_category_params
      attributes = %i[name_en name_el]
      attributes.push(:slug) if Current.user.admin?
      params.require(:article_category).permit(*attributes)
    end
  end
end
