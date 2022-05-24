# frozen_string_literal: true

module Admin
  class SnippetsController < Admin::BaseController
    before_action :authorize_resource_access, only: %i[index new create]
    before_action :set_snippet, only: %i[show edit update destroy]

    def index
      snippets = Snippet.matching(params[:query]).order(id: :desc)
      @pagy, @snippets = pagy(snippets)
    end

    def new
      @snippet = Snippet.new
    end

    def create
      @snippet = Snippet.new(snippet_params)
      if @snippet.save
        track_activity @snippet
        redirect_to [:admin, @snippet], notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @snippet.update(snippet_params)
        track_activity @snippet
        redirect_to [:admin, @snippet], notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @snippet.destroy
      track_activity @snippet
      redirect_to admin_snippets_url, notice: t(".success")
    end

    private

    def authorize_resource_access
      authorize(Snippet)
    end

    def set_breadcrumbs
      add_breadcrumb("Snippets", admin_snippets_path)
    end

    def set_snippet
      @snippet = Snippet.find(params[:id])
      authorize(@snippet)
      add_breadcrumb(@snippet.title, admin_snippet_path(@snippet))
    end

    def snippet_params
      params.require(:snippet).permit(:slug, :title_en, :title_el, :body_en, :body_el)
    end
  end
end
