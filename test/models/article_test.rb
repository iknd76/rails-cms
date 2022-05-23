# frozen_string_literal: true

require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "article category must exist" do
    article = Article.new(article_category: nil)
    article.validate
    assert_includes article.errors[:article_category], "must exist"
  end

  test "locale must be present" do
    article = Article.new(locale: "")
    article.validate
    assert_includes article.errors[:locale], "can't be blank"
  end

  test "locale must be available" do
    article = Article.new(locale: "fr")
    article.validate
    assert_includes article.errors[:locale], "is not included in the list"
  end

  test "title must be present" do
    article = Article.new(title: "")
    article.validate
    assert_includes article.errors[:title], "can't be blank"
  end

  test "body must be present" do
    article = Article.new(body: "")
    article.validate
    assert_includes article.errors[:body], "can't be blank"
  end

  test "status must be present" do
    article = Article.new(status: "")
    article.validate
    assert_includes article.errors[:status], "can't be blank"
  end

  test "set published on when published" do
    article = Article.draft.first
    assert_nil article.published_on

    article.published!
    assert_equal Time.zone.today, article.published_on
  end

  test "respect already set published on when published" do
    article = Article.draft.first
    assert_nil article.published_on

    date = Time.zone.today - 5.days
    article.update!(status: "published", published_on: date)
    assert_equal date, article.published_on
  end

  test "unset published on when unpublished" do
    article = Article.published.first
    assert_not_nil article.published_on

    article.draft!
    assert_nil article.published_on
  end
end
