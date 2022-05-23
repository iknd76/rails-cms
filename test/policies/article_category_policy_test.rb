# frozen_string_literal: true

require "test_helper"

class ArticleCategoryPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
    @category = article_categories(:one)
  end

  test "all active users should index categories" do
    assert ArticleCategoryPolicy.new(@admin, nil).index?
    assert ArticleCategoryPolicy.new(@standard, nil).index?
    assert_not ArticleCategoryPolicy.new(@banned, nil).index?
  end

  test "only admins should create categories" do
    assert ArticleCategoryPolicy.new(@admin, nil).create?
    assert_not ArticleCategoryPolicy.new(@standard, nil).create?
    assert_not ArticleCategoryPolicy.new(@banned, nil).create?
  end

  test "all active users should view category details" do
    assert ArticleCategoryPolicy.new(@admin, @standard).show?
    assert ArticleCategoryPolicy.new(@standard, @banned).show?
    assert_not ArticleCategoryPolicy.new(@banned, @standard).show?
  end

  test "all active users should update categories" do
    assert ArticleCategoryPolicy.new(@admin, @standard).update?
    assert ArticleCategoryPolicy.new(@standard, @banned).update?
    assert_not ArticleCategoryPolicy.new(@banned, @standard).update?
  end

  test "all active users should sort categories" do
    assert ArticleCategoryPolicy.new(@admin, @standard).sort?
    assert ArticleCategoryPolicy.new(@standard, @banned).sort?
    assert_not ArticleCategoryPolicy.new(@banned, @standard).sort?
  end

  test "only admins should destroy categories" do
    assert ArticleCategoryPolicy.new(@admin, @standard).destroy?
    assert_not ArticleCategoryPolicy.new(@standard, @banned).destroy?
    assert_not ArticleCategoryPolicy.new(@banned, @standard).destroy?
  end
end
