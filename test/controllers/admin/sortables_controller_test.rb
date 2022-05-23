# frozen_string_literal: true

require "test_helper"

module Admin
  class SortablesControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:katelyn)
    end

    test "should sort records" do
      assert_equal %w[one two three], ArticleCategory.order(:position).pluck(:slug)

      category = article_categories(:three)
      assert_difference("Activity.count") do
        post admin_sortables_url, params: { sgid: category.to_sgid_param, position: 1 }
      end
      assert_response :ok
      assert_equal %w[three one two], ArticleCategory.order(:position).pluck(:slug)

      activity = Activity.last
      assert_equal category, activity.trackable
      assert_equal "sort", activity.action
    end
  end
end
