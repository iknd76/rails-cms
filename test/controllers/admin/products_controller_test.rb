# frozen_string_literal: true

require "test_helper"

module Admin
  class ProductsControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:katelyn)
    end

    test "should get index" do
      get admin_products_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_product_url
      assert_response :success
    end

    test "should create product" do
      assert_difference("Activity.count") do
        assert_difference("Product.count") do
          post admin_products_url, params: { product: product_params }
        end
      end

      product = Product.last
      assert_redirected_to admin_product_url(product)

      activity = Activity.last
      assert_equal product, activity.trackable
      assert_equal "create", activity.action
    end

    test "should not create product with invalid params" do
      assert_no_difference("Activity.count") do
        assert_no_difference("Product.count") do
          post admin_products_url, params: { product: product_params(title_el: "") }
        end
      end
      assert_response :unprocessable_entity
    end

    test "should show product" do
      product = products(:one)
      get admin_product_url(product)
      assert_response :success
    end

    test "should get edit" do
      product = products(:one)
      get edit_admin_product_url(product)
      assert_response :success
    end

    test "should update product" do
      product = products(:one)
      assert_difference("Activity.count") do
        patch admin_product_url(product), params: { product: product_params }
      end
      assert_redirected_to admin_product_url(product)

      activity = Activity.last
      assert_equal product, activity.trackable
      assert_equal "update", activity.action
    end

    test "should not update product with invalid params" do
      product = products(:one)
      assert_no_difference("Activity.count") do
        patch admin_product_url(product), params: { product: product_params(title_en: "") }
      end
      assert_response :unprocessable_entity
    end

    test "should destroy product" do
      product = products(:one)
      assert_difference("Activity.count") do
        assert_difference("Product.count", -1) do
          delete admin_product_url(product)
        end
      end
      assert_redirected_to admin_products_url

      activity = Activity.last
      assert_equal product.id, activity.trackable_id
      assert_equal "destroy", activity.action
    end

    private

    def product_params(overrides = {})
      overrides.reverse_merge(
        product_category_id: product_categories(:one_a).id,
        supplier_id: suppliers(:one).id,
        title_en: "Test Product",
        title_el: "Test Product",
        body_en: "Test Product Body",
        body_el: "Test Product Body",
        status: "published"
      )
    end
  end
end
