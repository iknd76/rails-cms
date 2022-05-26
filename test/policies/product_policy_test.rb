# frozen_string_literal: true

require "test_helper"

class ProductPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
    @product = products(:one)
  end

  test "all active users should index products" do
    assert ProductPolicy.new(@admin, nil).index?
    assert ProductPolicy.new(@standard, nil).index?
    assert_not ProductPolicy.new(@banned, nil).index?
  end

  test "all active users should create products" do
    assert ProductPolicy.new(@admin, nil).create?
    assert ProductPolicy.new(@standard, nil).create?
    assert_not ProductPolicy.new(@banned, nil).create?
  end

  test "all active users should view product details" do
    assert ProductPolicy.new(@admin, @product).show?
    assert ProductPolicy.new(@standard, @product).show?
    assert_not ProductPolicy.new(@banned, @product).show?
  end

  test "all active users should update products" do
    assert ProductPolicy.new(@admin, @product).update?
    assert ProductPolicy.new(@standard, @product).update?
    assert_not ProductPolicy.new(@banned, @product).update?
  end

  test "all active users should destroy products" do
    assert ProductPolicy.new(@admin, @product).destroy?
    assert ProductPolicy.new(@standard, @product).destroy?
    assert_not ProductPolicy.new(@banned, @product).destroy?
  end
end
