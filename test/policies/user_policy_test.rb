# frozen_string_literal: true

require "test_helper"

class UserPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
  end

  test "only admins should index users" do
    assert UserPolicy.new(@admin, nil).index?
    assert_not UserPolicy.new(@standard, nil).index?
    assert_not UserPolicy.new(@banned, nil).index?
  end

  test "only admins should create users" do
    assert UserPolicy.new(@admin, nil).create?
    assert_not UserPolicy.new(@standard, nil).create?
    assert_not UserPolicy.new(@banned, nil).create?
  end

  test "only admins should view user details" do
    assert UserPolicy.new(@admin, @standard).show?
    assert_not UserPolicy.new(@standard, @banned).show?
    assert_not UserPolicy.new(@banned, @standard).show?
  end

  test "only admins should update users" do
    assert UserPolicy.new(@admin, @standard).update?
    assert_not UserPolicy.new(@standard, @banned).update?
    assert_not UserPolicy.new(@banned, @standard).update?
  end

  test "even admins should not update themselves" do
    assert_not UserPolicy.new(@admin, @admin).update?
  end

  test "only admins should destroy users" do
    assert UserPolicy.new(@admin, @standard).destroy?
    assert_not UserPolicy.new(@standard, @banned).destroy?
    assert_not UserPolicy.new(@banned, @standard).destroy?
  end

  test "even admins should not destroy themselves" do
    assert_not UserPolicy.new(@admin, @admin).destroy?
  end
end
