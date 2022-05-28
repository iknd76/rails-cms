# frozen_string_literal: true

module Admin
  class ProjectCategoriesController < Admin::BaseController
    before_action :authorize_resource_access, only: %i[index new create]
    before_action :set_project_category, only: %i[show edit update destroy]
    before_action :set_parent_categories, only: %i[new create edit update]

    def index
      @project_categories = ProjectCategory.roots
    end

    def new
      @project_category = ProjectCategory.new
    end

    def create
      @project_category = ProjectCategory.new(project_category_params)
      if @project_category.save
        track_activity @project_category
        redirect_to [:admin, @project_category], notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @project_category.update(project_category_params)
        track_activity @project_category
        redirect_to [:admin, @project_category], notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @project_category.destroy
      track_activity @project_category
      redirect_to admin_project_categories_url, notice: t(".success")
    end

    private

    def authorize_resource_access
      authorize(ProjectCategory)
    end

    def set_breadcrumbs
      add_breadcrumb("Project categories", admin_project_categories_path)
    end

    def set_project_category
      @project_category = ProjectCategory.find(params[:id])
      authorize(@project_category)
      add_breadcrumb(@project_category.name, admin_project_category_path(@project_category))
    end

    def set_parent_categories
      @parent_categories = ProjectCategory.roots.excluding(@project_category)
    end

    def project_category_params
      attributes = %i[name_en name_el parent_id]
      attributes.push(:slug) if Current.user.admin?
      params.require(:project_category).permit(*attributes)
    end
  end
end
