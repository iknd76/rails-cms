# frozen_string_literal: true

require "test_helper"

module Admin
  class SuppliersControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:eddard)
    end

    test "should get index" do
      get admin_suppliers_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_supplier_url
      assert_response :success
    end

    test "should create supplier" do
      assert_difference("Activity.count") do
        assert_difference("Supplier.count") do
          post admin_suppliers_url, params: { supplier: supplier_params }
        end
      end

      supplier = Supplier.last
      assert_redirected_to admin_supplier_url(supplier)

      activity = Activity.last
      assert_equal supplier, activity.trackable
      assert_equal "create", activity.action
    end

    test "should not create supplier with invalid params" do
      assert_no_difference("Activity.count") do
        assert_no_difference("Supplier.count") do
          post admin_suppliers_url, params: { supplier: supplier_params(name: "") }
        end
      end
      assert_response :unprocessable_entity
    end

    test "should show supplier" do
      supplier = suppliers(:one)
      get admin_supplier_url(supplier)
      assert_response :success
    end

    test "should get edit" do
      supplier = suppliers(:one)
      get edit_admin_supplier_url(supplier)
      assert_response :success
    end

    test "should update supplier" do
      supplier = suppliers(:one)
      assert_difference("Activity.count") do
        patch admin_supplier_url(supplier), params: { supplier: supplier_params }
      end
      assert_redirected_to admin_supplier_url(supplier)

      activity = Activity.last
      assert_equal supplier, activity.trackable
      assert_equal "update", activity.action
    end

    test "should not update supplier with invalid params" do
      supplier = suppliers(:one)
      assert_no_difference("Activity.count") do
        patch admin_supplier_url(supplier), params: { supplier: supplier_params(website: "not-a-uri") }
      end
      assert_response :unprocessable_entity
    end

    test "should destroy supplier" do
      supplier = suppliers(:one)
      assert_difference("Activity.count") do
        assert_difference("Supplier.count", -1) do
          delete admin_supplier_url(supplier)
        end
      end
      assert_redirected_to admin_suppliers_url

      activity = Activity.last
      assert_equal supplier.id, activity.trackable_id
      assert_equal "destroy", activity.action
    end

    private

    def supplier_params(overrides = {})
      overrides.reverse_merge(
        name: "Acme Inc",
        website: "https://www.acme.com",
        logo: fixture_file_upload("logo.png", "image/png")
      )
    end
  end
end
