# frozen_string_literal: true

require "test_helper"

module Auth
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    test "should get new" do
      get login_url
      assert_response :success
    end

    test "should log user in" do
      user = users(:katelyn)
      post login_url, params: { session: { email: user.email, password: "password" } }
      assert_redirected_to admin_root_url
      assert_equal user.token, session[:user_token]
      assert_in_delta 30.minutes.from_now, session[:expires_at], 1
      assert_equal "Welcome back, Katelyn!", flash[:notice]
    end

    test "should deny access when invalid credentials are provided" do
      user = users(:katelyn)
      post login_url, params: { session: { email: user.email, password: "wrong-password" } }
      assert_response :unprocessable_entity
      assert_nil session[:user_token]
      assert_nil session[:expires_at]
      assert_equal "Sorry, that's the wrong email or password.", flash[:alert]
    end

    test "should log user out" do
      user = users(:katelyn)
      log_in user
      get logout_url
      assert_redirected_to root_url
      assert_nil session[:user_token]
      assert_nil session[:expires_at]
      assert_equal "Bye bye, have a nice day!", flash[:notice]
    end
  end
end
