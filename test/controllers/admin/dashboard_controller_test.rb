# frozen_string_literal: true

require "test_helper"

module Admin
  class DashboardControllerTest < ActionDispatch::IntegrationTest
    test "should deny access to unauthenticated users" do
      get admin_root_url
      assert_redirected_to login_url
      assert_equal "You need to log in before you continue.", flash[:alert]
    end

    test "should grant access to authenticated users" do
      log_in users(:katelyn)

      get admin_root_url
      assert_response :success
    end

    test "should deny access to authenticated users with expired idle sessions" do
      log_in users(:katelyn)
      travel 1.hour

      get admin_root_url
      assert_redirected_to login_url
      assert_equal "Your session has expired. Please log in again to continue.", flash[:alert]
    end
  end
end
