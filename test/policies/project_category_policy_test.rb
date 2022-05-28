# frozen_string_literal: true

require "test_helper"

class ProjectCategoryPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
    @category = project_categories(:one)
  end

  test "all active users should index categories" do
    assert ProjectCategoryPolicy.new(@admin, nil).index?
    assert ProjectCategoryPolicy.new(@standard, nil).index?
    assert_not ProjectCategoryPolicy.new(@banned, nil).index?
  end

  test "only admins should create categories" do
    assert ProjectCategoryPolicy.new(@admin, nil).create?
    assert_not ProjectCategoryPolicy.new(@standard, nil).create?
    assert_not ProjectCategoryPolicy.new(@banned, nil).create?
  end

  test "all active users should view category details" do
    assert ProjectCategoryPolicy.new(@admin, @standard).show?
    assert ProjectCategoryPolicy.new(@standard, @banned).show?
    assert_not ProjectCategoryPolicy.new(@banned, @standard).show?
  end

  test "all active users should update categories" do
    assert ProjectCategoryPolicy.new(@admin, @standard).update?
    assert ProjectCategoryPolicy.new(@standard, @banned).update?
    assert_not ProjectCategoryPolicy.new(@banned, @standard).update?
  end

  test "all active users should sort categories" do
    assert ProjectCategoryPolicy.new(@admin, @standard).sort?
    assert ProjectCategoryPolicy.new(@standard, @banned).sort?
    assert_not ProjectCategoryPolicy.new(@banned, @standard).sort?
  end

  test "only admins should destroy categories" do
    assert ProjectCategoryPolicy.new(@admin, @standard).destroy?
    assert_not ProjectCategoryPolicy.new(@standard, @banned).destroy?
    assert_not ProjectCategoryPolicy.new(@banned, @standard).destroy?
  end
end
