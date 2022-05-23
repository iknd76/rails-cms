# frozen_string_literal: true

require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  test "user must exist" do
    activity = Activity.new(user: nil)
    activity.validate
    assert_includes activity.errors[:user], "must exist"
  end

  test "trackable must exist" do
    activity = Activity.new(trackable: nil)
    activity.validate
    assert_includes activity.errors[:trackable], "must exist"
  end

  test "trackable name must be present" do
    activity = Activity.new(trackable_name: "")
    activity.validate
    assert_includes activity.errors[:trackable_name], "can't be blank"
  end

  test "action must be present" do
    activity = Activity.new(action: "")
    activity.validate
    assert_includes activity.errors[:action], "can't be blank"
  end
end
