# frozen_string_literal: true

require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product category must exist" do
    product = Product.new(product_category: nil)
    product.validate
    assert_includes product.errors[:product_category], "must exist"
  end

  test "product category must not be a root category" do
    root_category = ProductCategory.roots.first
    product = Product.new(product_category: root_category)
    product.validate
    assert_includes product.errors[:product_category], "must not be a top-level category"
  end

  test "supplier must exist" do
    product = Product.new(supplier: nil)
    product.validate
    assert_includes product.errors[:supplier], "must exist"
  end

  test "title_en must be present" do
    product = Product.new(title_en: "")
    product.validate
    assert_includes product.errors[:title_en], "can't be blank"
  end

  test "title_el must be present" do
    product = Product.new(title_el: "")
    product.validate
    assert_includes product.errors[:title_el], "can't be blank"
  end

  test "body_en must be present" do
    product = Product.new(body_en: "")
    product.validate
    assert_includes product.errors[:body_en], "can't be blank"
  end

  test "body_el must be present" do
    product = Product.new(body_el: "")
    product.validate
    assert_includes product.errors[:body_el], "can't be blank"
  end

  test "status must be present" do
    product = Product.new(status: "")
    product.validate
    assert_includes product.errors[:status], "can't be blank"
  end

  test "set published on when published" do
    product = Product.draft.first
    assert_nil product.published_on

    product.published!
    assert_equal Time.zone.today, product.published_on
  end

  test "respect already set published on when published" do
    product = Product.draft.first
    assert_nil product.published_on

    date = Time.zone.today - 5.days
    product.update!(status: "published", published_on: date)
    assert_equal date, product.published_on
  end

  test "unset published on when unpublished" do
    product = Product.published.first
    assert_not_nil product.published_on

    product.draft!
    assert_nil product.published_on
  end
end
