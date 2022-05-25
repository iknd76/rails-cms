# frozen_string_literal: true

require "test_helper"

class SupplierTest < ActiveSupport::TestCase
  test "name must be present" do
    supplier = Supplier.new(name: "")
    supplier.validate
    assert_includes supplier.errors[:name], "can't be blank"
  end

  test "website must be present" do
    supplier = Supplier.new(website: "")
    supplier.validate
    assert_includes supplier.errors[:website], "can't be blank"
  end

  test "website must be properly formatted" do
    supplier = Supplier.new(website: "not-a-uri")
    supplier.validate
    assert_includes supplier.errors[:website], "is invalid"
  end
end
