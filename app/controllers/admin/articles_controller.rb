# frozen_string_literal: true

module Admin
  class ArticlesController < Admin::BaseController
    before_action :authorize_resource_access, only: %i[index new create]
    before_action :set_article, only: %i[show edit update destroy]

    def index
      articles = Article.matching(params[:query]).with_status(params[:status]).in_locale(params[:locale]).order(id: :desc)
      @pagy, @articles = pagy(articles)
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      if @article.save
        track_activity @article
        redirect_to [:admin, @article], notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @article.update(article_params)
        track_activity @article
        redirect_to [:admin, @article], notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article.destroy
      track_activity @article
      redirect_to admin_articles_url, notice: t(".success")
    end

    private

    def authorize_resource_access
      authorize(Article)
    end

    def set_breadcrumbs
      add_breadcrumb("Articles", admin_articles_path)
    end

    def set_article
      @article = Article.find(params[:id])
      authorize(@article)
      add_breadcrumb(@article.title, admin_article_path(@article))
    end

    def article_params
      params.require(:article).permit(:article_category_id, :locale, :title, :body, :status, :published_on)
    end
  end
end
