# frozen_string_literal: true

require "test_helper"

class ProjectPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
    @project = projects(:one)
  end

  test "all active users should index projects" do
    assert ProjectPolicy.new(@admin, nil).index?
    assert ProjectPolicy.new(@standard, nil).index?
    assert_not ProjectPolicy.new(@banned, nil).index?
  end

  test "all active users should create projects" do
    assert ProjectPolicy.new(@admin, nil).create?
    assert ProjectPolicy.new(@standard, nil).create?
    assert_not ProjectPolicy.new(@banned, nil).create?
  end

  test "all active users should view project details" do
    assert ProjectPolicy.new(@admin, @project).show?
    assert ProjectPolicy.new(@standard, @project).show?
    assert_not ProjectPolicy.new(@banned, @project).show?
  end

  test "all active users should update projects" do
    assert ProjectPolicy.new(@admin, @project).update?
    assert ProjectPolicy.new(@standard, @project).update?
    assert_not ProjectPolicy.new(@banned, @project).update?
  end

  test "all active users should destroy projects" do
    assert ProjectPolicy.new(@admin, @project).destroy?
    assert ProjectPolicy.new(@standard, @project).destroy?
    assert_not ProjectPolicy.new(@banned, @project).destroy?
  end
end
