# frozen_string_literal: true

require "test_helper"

module Admin
  class UsersControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:eddard)
    end

    test "should get index" do
      get admin_users_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_user_url
      assert_response :success
    end

    test "should create user" do
      assert_difference("Activity.count") do
        assert_difference("User.count") do
          post admin_users_url, params: { user: user_params }
        end
      end
      user = User.last
      assert_redirected_to admin_user_url(user)

      activity = Activity.last
      assert_equal user, activity.trackable
      assert_equal "create", activity.action
    end

    test "should not create user with invalid params" do
      assert_no_difference("Activity.count") do
        assert_no_difference("User.count") do
          post admin_users_url, params: { user: user_params(email: "not-an-email") }
        end
      end
      assert_response :unprocessable_entity
    end

    test "should show user" do
      user = users(:theon)
      get admin_user_url(user)
      assert_response :success
    end

    test "should get edit" do
      user = users(:theon)
      get edit_admin_user_url(user)
      assert_response :success
    end

    test "should update user" do
      user = users(:theon)
      assert_difference("Activity.count") do
        patch admin_user_url(user), params: { user: user_params }
      end
      assert_redirected_to admin_user_url(user)

      activity = Activity.last
      assert_equal user, activity.trackable
      assert_equal "update", activity.action
    end

    test "should not update user with invalid params" do
      user = users(:theon)
      assert_no_difference("Activity.count") do
        patch admin_user_url(user), params: { user: user_params(email: "not-an-email") }
      end
      assert_response :unprocessable_entity
    end

    test "should destroy user" do
      user = users(:theon)
      assert_difference("Activity.count") do
        assert_difference("User.count", -1) do
          delete admin_user_url(user)
        end
      end
      assert_redirected_to admin_users_url

      activity = Activity.last
      assert_equal user.id, activity.trackable_id
      assert_equal "User", activity.trackable_type
      assert_equal "Theon Greyjoy", activity.trackable_name
      assert_equal "destroy", activity.action
    end

    private

    def user_params(options = {})
      options.reverse_merge(
        first_name: "Jaime",
        last_name: "Lannister",
        email: "jaime@lannister.com",
        time_zone: "Paris",
        password: "password",
        password_confirmation: "password",
        role: "admin"
      )
    end
  end
end
