# frozen_string_literal: true

require "test_helper"

module Admin
  class SnippetsControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:eddard)
    end

    test "should get index" do
      get admin_snippets_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_snippet_url
      assert_response :success
    end

    test "should create snippet" do
      assert_difference("Activity.count") do
        assert_difference("Snippet.count") do
          post admin_snippets_url, params: { snippet: snippet_params }
        end
      end

      snippet = Snippet.last
      assert_redirected_to admin_snippet_url(snippet)

      activity = Activity.last
      assert_equal snippet, activity.trackable
      assert_equal "create", activity.action
    end

    test "should not create snippet with invalid params" do
      assert_no_difference("Activity.count") do
        assert_no_difference("Snippet.count") do
          post admin_snippets_url, params: { snippet: snippet_params(slug: "") }
        end
      end
      assert_response :unprocessable_entity
    end

    test "should show snippet" do
      snippet = snippets(:one)
      get admin_snippet_url(snippet)
      assert_response :success
    end

    test "should get edit" do
      snippet = snippets(:one)
      get edit_admin_snippet_url(snippet)
      assert_response :success
    end

    test "should update snippet" do
      snippet = snippets(:one)
      assert_difference("Activity.count") do
        patch admin_snippet_url(snippet), params: { snippet: snippet_params }
      end
      assert_redirected_to admin_snippet_url(snippet)

      activity = Activity.last
      assert_equal snippet, activity.trackable
      assert_equal "update", activity.action
    end

    test "should not update snippet with invalid params" do
      snippet = snippets(:one)
      assert_no_difference("Activity.count") do
        patch admin_snippet_url(snippet), params: { snippet: snippet_params(title_en: "") }
      end
      assert_response :unprocessable_entity
    end

    test "should destroy snippet" do
      snippet = snippets(:one)
      assert_difference("Activity.count") do
        assert_difference("Snippet.count", -1) do
          delete admin_snippet_url(snippet)
        end
      end
      assert_redirected_to admin_snippets_url

      activity = Activity.last
      assert_equal snippet.id, activity.trackable_id
      assert_equal "destroy", activity.action
    end

    private

    def snippet_params(overrides = {})
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
