# frozen_string_literal: true

module Admin
  class ProjectsController < Admin::BaseController
    before_action :authorize_resource_access, only: %i[index new create]
    before_action :set_project, only: %i[show edit update destroy]

    def index
      projects = Project.
                 includes(:project_category).
                 matching(params[:query]).
                 in_category(params[:category_id]).
                 with_status(params[:status]).
                 order(id: :desc)
      @pagy, @projects = pagy(projects)
    end

    def new
      @project = Project.new(lat: 38.011169, lng: 23.830884)
    end

    def create
      @project = Project.new(project_params)
      if @project.save
        track_activity @project
        redirect_to [:admin, @project], notice: t(".success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @project.update(project_params)
        track_activity @project
        redirect_to [:admin, @project], notice: t(".success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @project.destroy
      track_activity @project
      redirect_to admin_projects_url, notice: t(".success")
    end

    private

    def authorize_resource_access
      authorize(Project)
    end

    def set_breadcrumbs
      add_breadcrumb("Projects", admin_projects_path)
    end

    def set_project
      @project = Project.find(params[:id])
      authorize(@project)
      add_breadcrumb(@project.title, admin_project_path(@project))
    end

    def project_params
      params.require(:project).permit(:project_category_id, :title_en, :title_el, :body_en, :body_el, :lat, :lng, :status, :published_on, images: [])
    end
  end
end
