# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "first name must be present" do
    user = User.new(first_name: "")
    user.validate
    assert_includes user.errors[:first_name], "can't be blank"
  end

  test "last name must be present" do
    user = User.new(last_name: "")
    user.validate
    assert_includes user.errors[:last_name], "can't be blank"
  end

  test "email must be present" do
    user = User.new(email: "")
    user.validate
    assert_includes user.errors[:email], "can't be blank"
  end

  test "email must be properly formatted" do
    user = User.new(email: "not-an-email")
    user.validate
    assert_includes user.errors[:email], "is invalid"
  end

  test "email must be unique" do
    other = User.first
    user = User.new(email: other.email)
    user.validate
    assert_includes user.errors[:email], "has already been taken"
  end

  test "time zone must be present" do
    user = User.new(time_zone: "")
    user.validate
    assert_includes user.errors[:time_zone], "can't be blank"
  end

  test "time zone must be available" do
    user = User.new(time_zone: "Mars")
    user.validate
    assert_includes user.errors[:time_zone], "is not included in the list"
  end

  test "role must be present" do
    user = User.new(role: "")
    user.validate
    assert_includes user.errors[:role], "can't be blank"
  end

  test "authenticate with proper credentials" do
    user = users(:katelyn)
    assert_equal user, User.authenticate(email: user.email, password: "password")
  end

  test "authenticate with wrong password" do
    user = users(:katelyn)
    assert_nil User.authenticate(email: user.email, password: "wrong-password")
  end

  test "authenticate with unknown email" do
    assert_nil User.authenticate(email: "unknown@example.com", password: "password")
  end

  test "authenticate with banned user" do
    user = users(:theon)
    assert_nil User.authenticate(email: user.email, password: "password")
  end
end
