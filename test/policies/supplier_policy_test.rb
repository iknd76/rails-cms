# frozen_string_literal: true

require "test_helper"

class SupplierPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
    @supplier = suppliers(:one)
  end

  test "all active users should index suppliers" do
    assert SupplierPolicy.new(@admin, nil).index?
    assert SupplierPolicy.new(@standard, nil).index?
    assert_not SupplierPolicy.new(@banned, nil).index?
  end

  test "all active users should create suppliers" do
    assert SupplierPolicy.new(@admin, nil).create?
    assert SupplierPolicy.new(@standard, nil).create?
    assert_not SupplierPolicy.new(@banned, nil).create?
  end

  test "all active users should view supplier details" do
    assert SupplierPolicy.new(@admin, @supplier).show?
    assert SupplierPolicy.new(@standard, @supplier).show?
    assert_not SupplierPolicy.new(@banned, @supplier).show?
  end

  test "all active users should update suppliers" do
    assert SupplierPolicy.new(@admin, @supplier).update?
    assert SupplierPolicy.new(@standard, @supplier).update?
    assert_not SupplierPolicy.new(@banned, @supplier).update?
  end

  test "all active users should destroy suppliers" do
    assert SupplierPolicy.new(@admin, @supplier).destroy?
    assert SupplierPolicy.new(@standard, @supplier).destroy?
    assert_not SupplierPolicy.new(@banned, @supplier).destroy?
  end
end
