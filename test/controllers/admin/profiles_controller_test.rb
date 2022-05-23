# frozen_string_literal: true

require "test_helper"

module Admin
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:katelyn)
    end

    test "should get show" do
      get admin_profile_url
      assert_response :success
    end

    test "should update profile info" do
      patch admin_profile_url, params: { user: profile_params }
      assert_redirected_to admin_profile_path
      assert_equal "Your profile was successfully updated.", flash[:notice]
    end

    test "should not update profile info with invalid params" do
      patch admin_profile_url, params: { user: profile_params(email: "not-an-email", current_password: "wrong-password") }
      assert_response :unprocessable_entity
    end

    private

    def profile_params(options = {})
      options.reverse_merge(
        first_name: "Katelyn",
        last_name: "Stark",
        email: "kat@stark.com",
        time_zone: "Alaska",
        current_password: "password"
      )
    end
  end
end
