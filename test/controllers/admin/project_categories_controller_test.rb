# frozen_string_literal: true

require "test_helper"

module Admin
  class ProjectCategoriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:eddard)
    end

    test "should get index" do
      get admin_project_categories_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_project_category_url
      assert_response :success
    end

    test "should create category" do
      assert_difference("Activity.count") do
        assert_difference("ProjectCategory.count") do
          post admin_project_categories_url, params: { project_category: category_params }
        end
      end

      category = ProjectCategory.last
      assert_redirected_to admin_project_category_url(category)

      activity = Activity.last
      assert_equal category, activity.trackable
      assert_equal "create", activity.action
    end

    test "should not create category with invalid params" do
      assert_no_difference("Activity.count") do
        assert_no_difference("ProjectCategory.count") do
          post admin_project_categories_url, params: { project_category: category_params(slug: "") }
        end
      end
      assert_response :unprocessable_entity
    end

    test "should show category" do
      category = project_categories(:one_a)
      get admin_project_category_url(category)
      assert_response :success
    end

    test "should get edit" do
      category = project_categories(:one_a)
      get edit_admin_project_category_url(category)
      assert_response :success
    end

    test "should update category" do
      category = project_categories(:one_a)
      assert_difference("Activity.count") do
        patch admin_project_category_url(category), params: { project_category: category_params }
      end
      assert_redirected_to admin_project_category_url(category)

      activity = Activity.last
      assert_equal category, activity.trackable
      assert_equal "update", activity.action
    end

    test "should not update category with invalid params" do
      category = project_categories(:one_a)
      assert_no_difference("Activity.count") do
        patch admin_project_category_url(category), params: { project_category: category_params(slug: "") }
      end
      assert_response :unprocessable_entity
    end

    test "should destroy category" do
      category = project_categories(:one_a)
      assert_difference("Activity.count") do
        assert_difference("ProjectCategory.count", -1) do
          delete admin_project_category_url(category)
        end
      end
      assert_redirected_to admin_project_categories_url

      activity = Activity.last
      assert_equal category.id, activity.trackable_id
      assert_equal "destroy", activity.action
    end

    private

    def category_params(overrides = {})
      overrides.reverse_merge(
        parent_id: project_categories(:one).id,
        slug: "unique-slug",
        name_en: "English name",
        name_el: "Greek name"
      )
    end
  end
end
