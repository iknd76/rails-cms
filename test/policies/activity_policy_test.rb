# frozen_string_literal: true

require "test_helper"

class ActivityPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
  end

  test "only admins should index activities" do
    assert ActivityPolicy.new(@admin, nil).index?
    assert_not ActivityPolicy.new(@standard, nil).index?
    assert_not ActivityPolicy.new(@banned, nil).index?
  end
end
