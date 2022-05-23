# frozen_string_literal: true

require "test_helper"

class ArticlePolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
    @article = articles(:one)
  end

  test "all active users should index articles" do
    assert ArticlePolicy.new(@admin, nil).index?
    assert ArticlePolicy.new(@standard, nil).index?
    assert_not ArticlePolicy.new(@banned, nil).index?
  end

  test "all active users should create articles" do
    assert ArticlePolicy.new(@admin, nil).create?
    assert ArticlePolicy.new(@standard, nil).create?
    assert_not ArticlePolicy.new(@banned, nil).create?
  end

  test "all active users should view article details" do
    assert ArticlePolicy.new(@admin, @article).show?
    assert ArticlePolicy.new(@standard, @article).show?
    assert_not ArticlePolicy.new(@banned, @article).show?
  end

  test "all active users should update articles" do
    assert ArticlePolicy.new(@admin, @article).update?
    assert ArticlePolicy.new(@standard, @article).update?
    assert_not ArticlePolicy.new(@banned, @article).update?
  end

  test "all active users should destroy articles" do
    assert ArticlePolicy.new(@admin, @article).destroy?
    assert ArticlePolicy.new(@standard, @article).destroy?
    assert_not ArticlePolicy.new(@banned, @article).destroy?
  end
end
