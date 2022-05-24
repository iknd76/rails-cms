# frozen_string_literal: true

require "test_helper"

class PagePolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
    @page = pages(:one)
  end

  test "all active users should index pages" do
    assert PagePolicy.new(@admin, nil).index?
    assert PagePolicy.new(@standard, nil).index?
    assert_not PagePolicy.new(@banned, nil).index?
  end

  test "only admin users should create pages" do
    assert PagePolicy.new(@admin, nil).create?
    assert_not PagePolicy.new(@standard, nil).create?
    assert_not PagePolicy.new(@banned, nil).create?
  end

  test "all active users should view page details" do
    assert PagePolicy.new(@admin, @page).show?
    assert PagePolicy.new(@standard, @page).show?
    assert_not PagePolicy.new(@banned, @page).show?
  end

  test "all active users should update pages" do
    assert PagePolicy.new(@admin, @page).update?
    assert PagePolicy.new(@standard, @page).update?
    assert_not PagePolicy.new(@banned, @page).update?
  end

  test "only admin users should destroy pages" do
    assert PagePolicy.new(@admin, @page).destroy?
    assert_not PagePolicy.new(@standard, @page).destroy?
    assert_not PagePolicy.new(@banned, @page).destroy?
  end
end
