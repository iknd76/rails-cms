# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_28_175907) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.integer "position", default: 1, null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "trackable_type", null: false
    t.bigint "trackable_id", null: false
    t.string "trackable_name", null: false
    t.string "action", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "article_categories", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name_en", null: false
    t.string "name_el", null: false
    t.integer "position", default: 1, null: false
    t.integer "articles_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_article_categories_on_slug", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "article_category_id", null: false
    t.string "locale", default: "en", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.string "tags", default: [], null: false, array: true
    t.integer "status", default: 0, null: false
    t.date "published_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_category_id"], name: "index_articles_on_article_category_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title_en", null: false
    t.string "title_el", null: false
    t.text "body_en", null: false
    t.text "body_el", null: false
    t.text "description_en"
    t.text "description_el"
    t.text "keywords_en"
    t.text "keywords_el"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name_en", null: false
    t.string "name_el", null: false
    t.bigint "parent_id"
    t.integer "position", default: 1, null: false
    t.integer "products_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_product_categories_on_slug", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.bigint "product_category_id", null: false
    t.bigint "supplier_id", null: false
    t.string "title_en", null: false
    t.string "title_el", null: false
    t.text "body_en", null: false
    t.text "body_el", null: false
    t.string "tags", default: [], null: false, array: true
    t.integer "status", default: 0, null: false
    t.date "published_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "project_categories", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name_en", null: false
    t.string "name_el", null: false
    t.bigint "parent_id"
    t.integer "position", default: 1, null: false
    t.integer "projects_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_project_categories_on_slug", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "project_category_id", null: false
    t.string "title_en", null: false
    t.string "title_el", null: false
    t.text "body_en", null: false
    t.text "body_el", null: false
    t.decimal "lat", precision: 10, scale: 6, null: false
    t.decimal "lng", precision: 10, scale: 6, null: false
    t.string "tags", default: [], null: false, array: true
    t.integer "status", null: false
    t.date "published_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_category_id"], name: "index_projects_on_project_category_id"
  end

  create_table "snippets", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title_en", null: false
    t.string "title_el", null: false
    t.text "body_en", null: false
    t.text "body_el", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_snippets_on_slug", unique: true
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name", null: false
    t.string "website", null: false
    t.integer "products_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "time_zone", default: "UTC", null: false
    t.string "password_digest", null: false
    t.string "token", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "users"
  add_foreign_key "articles", "article_categories"
  add_foreign_key "products", "product_categories"
  add_foreign_key "products", "suppliers"
  add_foreign_key "projects", "project_categories"
end
