# frozen_string_literal: true

require "test_helper"

module Admin
  class ActivitiesControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:eddard)
    end

    test "should get index" do
      get admin_activities_url
      assert_response :success
    end
  end
end
