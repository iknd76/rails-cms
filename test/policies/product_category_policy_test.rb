# frozen_string_literal: true

require "test_helper"

class ProductCategoryPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
    @category = product_categories(:one)
  end

  test "all active users should index categories" do
    assert ProductCategoryPolicy.new(@admin, nil).index?
    assert ProductCategoryPolicy.new(@standard, nil).index?
    assert_not ProductCategoryPolicy.new(@banned, nil).index?
  end

  test "only admins should create categories" do
    assert ProductCategoryPolicy.new(@admin, nil).create?
    assert_not ProductCategoryPolicy.new(@standard, nil).create?
    assert_not ProductCategoryPolicy.new(@banned, nil).create?
  end

  test "all active users should view category details" do
    assert ProductCategoryPolicy.new(@admin, @standard).show?
    assert ProductCategoryPolicy.new(@standard, @banned).show?
    assert_not ProductCategoryPolicy.new(@banned, @standard).show?
  end

  test "all active users should update categories" do
    assert ProductCategoryPolicy.new(@admin, @standard).update?
    assert ProductCategoryPolicy.new(@standard, @banned).update?
    assert_not ProductCategoryPolicy.new(@banned, @standard).update?
  end

  test "all active users should sort categories" do
    assert ProductCategoryPolicy.new(@admin, @standard).sort?
    assert ProductCategoryPolicy.new(@standard, @banned).sort?
    assert_not ProductCategoryPolicy.new(@banned, @standard).sort?
  end

  test "only admins should destroy categories" do
    assert ProductCategoryPolicy.new(@admin, @standard).destroy?
    assert_not ProductCategoryPolicy.new(@standard, @banned).destroy?
    assert_not ProductCategoryPolicy.new(@banned, @standard).destroy?
  end
end
