# frozen_string_literal: true

class ArticlesController < SiteController
  def index
    articles = Article.
               includes(:article_category).
               published.
               in_locale(I18n.locale).
               in_category(params[:category_id]).
               order(published_on: :desc, id: :desc)
    @pagy, @articles = pagy(articles)
  end
end
