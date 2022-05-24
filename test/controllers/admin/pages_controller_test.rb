# frozen_string_literal: true

require "test_helper"

module Admin
  class PagesControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:eddard)
    end

    test "should get index" do
      get admin_pages_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_page_url
      assert_response :success
    end

    test "should create page" do
      assert_difference("Activity.count") do
        assert_difference("Page.count") do
          post admin_pages_url, params: { page: page_params }
        end
      end

      page = Page.last
      assert_redirected_to admin_page_url(page)

      activity = Activity.last
      assert_equal page, activity.trackable
      assert_equal "create", activity.action
    end

    test "should not create page with invalid params" do
      assert_no_difference("Activity.count") do
        assert_no_difference("Page.count") do
          post admin_pages_url, params: { page: page_params(slug: "") }
        end
      end
      assert_response :unprocessable_entity
    end

    test "should show page" do
      page = pages(:one)
      get admin_page_url(page)
      assert_response :success
    end

    test "should get edit" do
      page = pages(:one)
      get edit_admin_page_url(page)
      assert_response :success
    end

    test "should update page" do
      page = pages(:one)
      assert_difference("Activity.count") do
        patch admin_page_url(page), params: { page: page_params }
      end
      assert_redirected_to admin_page_url(page)

      activity = Activity.last
      assert_equal page, activity.trackable
      assert_equal "update", activity.action
    end

    test "should not update page with invalid params" do
      page = pages(:one)
      assert_no_difference("Activity.count") do
        patch admin_page_url(page), params: { page: page_params(title_en: "") }
      end
      assert_response :unprocessable_entity
    end

    test "should destroy page" do
      page = pages(:one)
      assert_difference("Activity.count") do
        assert_difference("Page.count", -1) do
          delete admin_page_url(page)
        end
      end
      assert_redirected_to admin_pages_url

      activity = Activity.last
      assert_equal page.id, activity.trackable_id
      assert_equal "destroy", activity.action
    end

    private

    def page_params(overrides = {})
      overrides.reverse_merge(
        slug: "unique-slug",
        title_en: "English title",
        body_en: "English body",
        title_el: "Greek title",
        body_el: "Greek body"
      )
    end
  end
end
