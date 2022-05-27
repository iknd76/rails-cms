# frozen_string_literal: true

require "test_helper"

class RackAttackTest < ActionDispatch::IntegrationTest
  setup do
    Rack::Attack.enabled = true
    Rack::Attack.reset!
  end

  teardown do
    Rack::Attack.reset!
    Rack::Attack.enabled = false
  end

  test "should block excessive login attempts" do
    login_params = { session: { email: "unknown@example.com", password: "password" } }

    10.times do
      post login_url, params: login_params, headers: { "REMOTE_ADDR" => "1.2.3.4" }
      assert_response :unprocessable_entity
    end

    post login_url, params: login_params, headers: { "REMOTE_ADDR" => "1.2.3.4" }
    assert_response :service_unavailable

    travel(61.minutes) do
      post login_url, params: login_params, headers: { "REMOTE_ADDR" => "1.2.3.4" }
      assert_response :unprocessable_entity
    end
  end

  test "should block pentesters requesting wordpress urls" do
    3.times do
      get "#{root_url}/wp-admin", headers: { "REMOTE_ADDR" => "1.2.3.4" }
      assert_response :service_unavailable
    end

    get root_url, headers: { "REMOTE_ADDR" => "1.2.3.4" }
    assert_response :service_unavailable

    travel(31.minutes) do
      get root_url, headers: { "REMOTE_ADDR" => "1.2.3.4" }
      assert_response :success
    end
  end

  test "should block excessive requests in admin area" do
    log_in users(:katelyn)

    100.times do
      get admin_root_url, headers: { "REMOTE_ADDR" => "1.2.3.4" }
      assert_response :success
    end

    get admin_root_url, headers: { "REMOTE_ADDR" => "1.2.3.4" }
    assert_response :service_unavailable

    travel(2.minutes) do
      get admin_root_url, headers: { "REMOTE_ADDR" => "1.2.3.4" }
      assert_response :success
    end
  end
end
