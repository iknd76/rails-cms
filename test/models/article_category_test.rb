# frozen_string_literal: true

require "test_helper"

class ArticleCategoryTest < ActiveSupport::TestCase
  test "slug must be present" do
    article_category = ArticleCategory.new(slug: "")
    article_category.validate
    assert_includes article_category.errors[:slug], "can't be blank"
  end

  test "slug must be unique" do
    other = ArticleCategory.first
    article_category = ArticleCategory.new(slug: other.slug)
    article_category.validate
    assert_includes article_category.errors[:slug], "has already been taken"
  end

  test "slug must be valid" do
    article_category = ArticleCategory.new(slug: "with spaces and special characters $%^")
    article_category.validate
    assert_includes article_category.errors[:slug], "is invalid"
  end

  test "name_en must be present" do
    article_category = ArticleCategory.new(name_en: "")
    article_category.validate
    assert_includes article_category.errors[:name_en], "can't be blank"
  end

  test "name_el must be present" do
    article_category = ArticleCategory.new(name_el: "")
    article_category.validate
    assert_includes article_category.errors[:name_el], "can't be blank"
  end
end
