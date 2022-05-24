# frozen_string_literal: true

require "test_helper"

class SnippetPolicyTest < ActiveSupport::TestCase
  setup do
    @admin = users(:eddard)
    @standard = users(:katelyn)
    @banned = users(:theon)
    @snippet = snippets(:one)
  end

  test "all active users should index snippets" do
    assert SnippetPolicy.new(@admin, nil).index?
    assert SnippetPolicy.new(@standard, nil).index?
    assert_not SnippetPolicy.new(@banned, nil).index?
  end

  test "only admin users should create snippets" do
    assert SnippetPolicy.new(@admin, nil).create?
    assert_not SnippetPolicy.new(@standard, nil).create?
    assert_not SnippetPolicy.new(@banned, nil).create?
  end

  test "all active users should view snippet details" do
    assert SnippetPolicy.new(@admin, @snippet).show?
    assert SnippetPolicy.new(@standard, @snippet).show?
    assert_not SnippetPolicy.new(@banned, @snippet).show?
  end

  test "all active users should update snippets" do
    assert SnippetPolicy.new(@admin, @snippet).update?
    assert SnippetPolicy.new(@standard, @snippet).update?
    assert_not SnippetPolicy.new(@banned, @snippet).update?
  end

  test "only admin users should destroy snippets" do
    assert SnippetPolicy.new(@admin, @snippet).destroy?
    assert_not SnippetPolicy.new(@standard, @snippet).destroy?
    assert_not SnippetPolicy.new(@banned, @snippet).destroy?
  end
end
