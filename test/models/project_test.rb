# frozen_string_literal: true

require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "project category must exist" do
    project = Project.new(project_category: nil)
    project.validate
    assert_includes project.errors[:project_category], "must exist"
  end

  test "project category must not be a root category" do
    root_category = ProjectCategory.roots.first
    project = Project.new(project_category: root_category)
    project.validate
    assert_includes project.errors[:project_category], "must not be a top-level category"
  end

  test "title_en must be present" do
    project = Project.new(title_en: "")
    project.validate
    assert_includes project.errors[:title_en], "can't be blank"
  end

  test "title_el must be present" do
    project = Project.new(title_el: "")
    project.validate
    assert_includes project.errors[:title_el], "can't be blank"
  end

  test "body_en must be present" do
    project = Project.new(body_en: "")
    project.validate
    assert_includes project.errors[:body_en], "can't be blank"
  end

  test "body_el must be present" do
    project = Project.new(body_el: "")
    project.validate
    assert_includes project.errors[:body_el], "can't be blank"
  end

  test "status must be present" do
    project = Project.new(status: "")
    project.validate
    assert_includes project.errors[:status], "can't be blank"
  end

  test "set published on when published" do
    project = Project.draft.first
    assert_nil project.published_on

    project.published!
    assert_equal Time.zone.today, project.published_on
  end

  test "respect already set published on when published" do
    project = Project.draft.first
    assert_nil project.published_on

    date = Time.zone.today - 5.days
    project.update!(status: "published", published_on: date)
    assert_equal date, project.published_on
  end

  test "unset published on when unpublished" do
    project = Project.published.first
    assert_not_nil project.published_on

    project.draft!
    assert_nil project.published_on
  end
end
