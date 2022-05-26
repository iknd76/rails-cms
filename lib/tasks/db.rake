# frozen_string_literal: true

namespace :db do
  desc "Fill up the database with dummy data"
  task populate: :environment do
    raise "Should not be executed on #{Rails.env} environment" unless Rails.env.development?

    %w[activities users article_categories articles pages snippets suppliers product_categories].each do |table_name|
      ApplicationRecord.connection.execute("TRUNCATE #{table_name} CASCADE")
    end

    # Create some users
    progressbar_format = "\e[0;32m%t\e[0m %B %j%%"
    progressbar = ProgressBar.create(title: "Users", total: 23, format: progressbar_format, length: 80, progress_mark: ".")
    time_zones = ActiveSupport::TimeZone.all.map(&:name)
    roles = User.roles.keys
    22.times do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = Faker::Internet.email(name: [first_name, last_name].join(" "))
      User.create(
        first_name:,
        last_name:,
        email:,
        time_zone: time_zones.sample,
        role: roles.sample,
        password: "password"
      )
      progressbar.increment
    end
    User.create(first_name: "Eddard", last_name: "Stark", email: "eddard@stark.com", role: "admin", password: "password")
    progressbar.increment

    # Create some article categories
    progressbar = ProgressBar.create(title: "Article categories", total: 17, format: progressbar_format, length: 80, progress_mark: ".")
    17.times do
      name = Faker::Hobby.activity
      slug = name.parameterize
      ArticleCategory.create(slug:, name_en: name, name_el: name)
      progressbar.increment
    end

    # Create some articles
    progressbar = ProgressBar.create(title: "Articles", total: 143, format: progressbar_format, length: 80, progress_mark: ".")
    article_category_ids = ArticleCategory.ids
    locales = I18n.available_locales.map(&:name)
    143.times do
      status = rand(100) < 30 ? "draft" : "published"
      Article.create(
        article_category_id: article_category_ids.sample,
        locale: locales.sample,
        title: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4),
        body: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4),
        tags: Faker::Lorem.words,
        status:,
        published_on: status == "draft" ? nil : Faker::Date.backward(days: 365)
      )
      progressbar.increment
    end

    # Create some pages
    progressbar = ProgressBar.create(title: "Pages", total: 14, format: progressbar_format, length: 80, progress_mark: ".")
    14.times do
      title = Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4)
      Page.create(
        slug: title.parameterize,
        title_en: title,
        title_el: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4),
        body_en: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4),
        body_el: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4),
        description_en: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
        description_el: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
        keywords_en: Faker::Lorem.words.join(","),
        keywords_el: Faker::Lorem.words.join(",")
      )
      progressbar.increment
    end

    # Create some snippets
    progressbar = ProgressBar.create(title: "Snippets", total: 9, format: progressbar_format, length: 80, progress_mark: ".")
    9.times do
      title = Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 2)
      Snippet.create(
        slug: title.parameterize,
        title_en: title,
        title_el: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 2),
        body_en: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2),
        body_el: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 2)
      )
      progressbar.increment
    end

    # Create some product categories
    progressbar = ProgressBar.create(title: "Product categories", total: 28, format: progressbar_format, length: 80, progress_mark: ".")
    5.times do
      name = Faker::Commerce.department
      slug = name.parameterize
      ProductCategory.create(slug:, name_en: name, name_el: name)
      progressbar.increment
    end

    root_ids = ProductCategory.roots.ids
    23.times do
      name = Faker::Commerce.department
      slug = name.parameterize
      ProductCategory.create(slug:, name_en: name, name_el: name, parent_id: root_ids.sample)
      progressbar.increment
    end

    # Create some suppliers
    progressbar = ProgressBar.create(title: "Suppliers", total: 31, format: progressbar_format, length: 80, progress_mark: ".")
    31.times do
      name = Faker::Company.name
      website = "https://www.#{name.parameterize}.com"
      Supplier.create(name:, website:)
      progressbar.increment
    end
  end
end
