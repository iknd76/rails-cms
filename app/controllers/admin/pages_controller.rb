# frozen_string_literal: true

module Admin
  class PagesController < Admin::BaseController
    before_action :authorize_resource_access, only: %i[index new create]
    before_action :set_page, only: %i[show edit update destroy]

    def index
      pages = Page.matching(params[:query]).order(id: :desc)
      @pagy, @pages = pagy(pages)
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(page_params)
      if @page.save
        track_activity @page
        redirect_to [:admin, @page], notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @page.update(page_params)
        track_activity @page
        redirect_to [:admin, @page], notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @page.destroy
      track_activity @page
      redirect_to admin_pages_url, notice: t(".success")
    end

    private

    def authorize_resource_access
      authorize(Page)
    end

    def set_breadcrumbs
      add_breadcrumb("Pages", admin_pages_path)
    end

    def set_page
      @page = Page.find(params[:id])
      authorize(@page)
      add_breadcrumb(@page.title, admin_page_path(@page))
    end

    def page_params
      params.require(:page).permit(:slug, :title_en, :title_el, :body_en, :body_el, :description_en, :description_el, :keywords_en, :keywords_el)
    end
  end
end
