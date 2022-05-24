# frozen_string_literal: true

require "test_helper"

class PageTest < ActiveSupport::TestCase
  test "slug must be present" do
    snippet = Page.new(slug: "")
    snippet.validate
    assert_includes snippet.errors[:slug], "can't be blank"
  end

  test "slug must be unique" do
    other = Page.first
    snippet = Page.new(slug: other.slug)
    snippet.validate
    assert_includes snippet.errors[:slug], "has already been taken"
  end

  test "slug must be properly formatted" do
    snippet = Page.new(slug: "with spaces and special characters #$%")
    snippet.validate
    assert_includes snippet.errors[:slug], "is invalid"
  end

  test "title_en must be present" do
    snippet = Page.new(title_en: "")
    snippet.validate
    assert_includes snippet.errors[:title_en], "can't be blank"
  end

  test "title_el must be present" do
    snippet = Page.new(title_el: "")
    snippet.validate
    assert_includes snippet.errors[:title_el], "can't be blank"
  end

  test "body_en must be present" do
    snippet = Page.new(body_en: "")
    snippet.validate
    assert_includes snippet.errors[:body_en], "can't be blank"
  end

  test "body_el must be present" do
    snippet = Page.new(body_el: "")
    snippet.validate
    assert_includes snippet.errors[:body_el], "can't be blank"
  end
end
