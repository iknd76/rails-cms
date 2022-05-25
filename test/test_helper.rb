# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module ActionDispatch
  class IntegrationTest
    parallelize_setup do |instance|
      ActiveStorage::Blob.service.root = "#{ActiveStorage::Blob.service.root}-#{instance}"
    end

    def log_in(user)
      post login_url, params: { session: { email: user.email, password: "password" } }
    end

    def after_teardown
      super
      FileUtils.rm_rf(ActiveStorage::Blob.service.root)
    end
  end
end
