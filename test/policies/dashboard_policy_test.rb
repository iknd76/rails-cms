# frozen_string_literal: true

require "test_helper"

class DashboardPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
  end

  test "only active users should access the dashboard" do
    assert DashboardPolicy.new(@admin, nil).show?
    assert DashboardPolicy.new(@standard, nil).show?
    assert_not DashboardPolicy.new(@banned, nil).show?
  end
end
