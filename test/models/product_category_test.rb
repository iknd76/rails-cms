# frozen_string_literal: true

require "test_helper"

class ProductCategoryTest < ActiveSupport::TestCase
  test "slug must be present" do
    category = ProductCategory.new(slug: "")
    category.validate
    assert_includes category.errors[:slug], "can't be blank"
  end

  test "slug must be unique" do
    other = ProductCategory.first
    category = ProductCategory.new(slug: other.slug)
    category.validate
    assert_includes category.errors[:slug], "has already been taken"
  end

  test "slug must be valid" do
    category = ProductCategory.new(slug: "with spaces and special characters $%^")
    category.validate
    assert_includes category.errors[:slug], "is invalid"
  end

  test "name_en must be present" do
    category = ProductCategory.new(name_en: "")
    category.validate
    assert_includes category.errors[:name_en], "can't be blank"
  end

  test "name_el must be present" do
    category = ProductCategory.new(name_el: "")
    category.validate
    assert_includes category.errors[:name_el], "can't be blank"
  end

  test "parent must be a root category" do
    other = ProductCategory.where.not(parent_id: nil).first
    category = ProductCategory.new(parent: other)
    category.validate
    assert_includes category.errors[:parent_id], "must be a root category"
  end

  test "a root category with children should not be assigned to another root" do
    category = product_categories(:one)
    assert category.children.any?

    other = product_categories(:two)
    category.parent = other
    category.validate
    assert_includes category.errors[:parent_id], "cannot be set while having assigned children"
  end

  test "a root category without children should be assignable to another root" do
    category = product_categories(:three)
    assert category.children.empty?

    other = product_categories(:two)
    category.parent = other
    category.validate
    assert_empty category.errors[:parent_id]
  end

  test "parent must be a different record" do
    category = ProductCategory.roots.first
    category.parent = category
    category.validate
    assert_includes category.errors[:parent_id], "must be a different category"
  end
end
