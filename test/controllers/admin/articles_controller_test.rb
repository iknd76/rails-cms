# frozen_string_literal: true

require "test_helper"

module Admin
  class ArticlesControllerTest < ActionDispatch::IntegrationTest
    setup do
      log_in users(:katelyn)
    end

    test "should get index" do
      get admin_articles_url
      assert_response :success
    end

    test "should get new" do
      get new_admin_article_url
      assert_response :success
    end

    test "should create article" do
      assert_difference("Activity.count") do
        assert_difference("Article.count") do
          post admin_articles_url, params: { article: article_params }
        end
      end

      article = Article.last
      assert_redirected_to admin_article_url(article)

      activity = Activity.last
      assert_equal article, activity.trackable
      assert_equal "create", activity.action
    end

    test "should not create article with invalid params" do
      assert_no_difference("Activity.count") do
        assert_no_difference("Article.count") do
          post admin_articles_url, params: { article: article_params(locale: "fr") }
        end
      end
      assert_response :unprocessable_entity
    end

    test "should show article" do
      article = articles(:one)
      get admin_article_url(article)
      assert_response :success
    end

    test "should get edit" do
      article = articles(:one)
      get edit_admin_article_url(article)
      assert_response :success
    end

    test "should update article" do
      article = articles(:one)
      assert_difference("Activity.count") do
        patch admin_article_url(article), params: { article: article_params }
      end
      assert_redirected_to admin_article_url(article)

      activity = Activity.last
      assert_equal article, activity.trackable
      assert_equal "update", activity.action
    end

    test "should not update article with invalid params" do
      article = articles(:one)
      assert_no_difference("Activity.count") do
        patch admin_article_url(article), params: { article: article_params(title: "") }
      end
      assert_response :unprocessable_entity
    end

    test "should destroy article" do
      article = articles(:one)
      assert_difference("Activity.count") do
        assert_difference("Article.count", -1) do
          delete admin_article_url(article)
        end
      end
      assert_redirected_to admin_articles_url

      activity = Activity.last
      assert_equal article.id, activity.trackable_id
      assert_equal "destroy", activity.action
    end

    private

    def article_params(overrides = {})
      overrides.reverse_merge(
        article_category_id: article_categories(:one).id,
        locale: "en",
        title: "Test Article",
        body: "Test Article Body",
        status: "published"
      )
    end
  end
end
