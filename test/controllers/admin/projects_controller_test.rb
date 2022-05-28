# frozen_string_literal: true

require "test_helper"

module Admin
  class ProjectsControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:katelyn)
    end

    test "should get index" do
      get admin_projects_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_project_url
      assert_response :success
    end

    test "should create project" do
      assert_difference("Activity.count") do
        assert_difference("Project.count") do
          post admin_projects_url, params: { project: project_params }
        end
      end

      project = Project.last
      assert_redirected_to admin_project_url(project)

      activity = Activity.last
      assert_equal project, activity.trackable
      assert_equal "create", activity.action
    end

    test "should not create project with invalid params" do
      assert_no_difference("Activity.count") do
        assert_no_difference("Project.count") do
          post admin_projects_url, params: { project: project_params(title_el: "") }
        end
      end
      assert_response :unprocessable_entity
    end

    test "should show project" do
      project = projects(:one)
      get admin_project_url(project)
      assert_response :success
    end

    test "should get edit" do
      project = projects(:one)
      get edit_admin_project_url(project)
      assert_response :success
    end

    test "should update project" do
      project = projects(:one)
      assert_difference("Activity.count") do
        patch admin_project_url(project), params: { project: project_params }
      end
      assert_redirected_to admin_project_url(project)

      activity = Activity.last
      assert_equal project, activity.trackable
      assert_equal "update", activity.action
    end

    test "should not update project with invalid params" do
      project = projects(:one)
      assert_no_difference("Activity.count") do
        patch admin_project_url(project), params: { project: project_params(title_en: "") }
      end
      assert_response :unprocessable_entity
    end

    test "should destroy project" do
      project = projects(:one)
      assert_difference("Activity.count") do
        assert_difference("Project.count", -1) do
          delete admin_project_url(project)
        end
      end
      assert_redirected_to admin_projects_url

      activity = Activity.last
      assert_equal project.id, activity.trackable_id
      assert_equal "destroy", activity.action
    end

    private

    def project_params(overrides = {})
      overrides.reverse_merge(
        project_category_id: project_categories(:one_a).id,
        title_en: "Test Project",
        title_el: "Test Project",
        body_en: "Test Project Body",
        body_el: "Test Project Body",
        status: "published"
      )
    end
  end
end
