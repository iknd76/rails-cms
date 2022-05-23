# frozen_string_literal: true

class CreateArticleCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :article_categories do |t|
      t.string :slug, null: false
      t.string :name_en, null: false
      t.string :name_el, null: false
      t.integer :position, null: false, default: 1
      t.integer :articles_count, null: false, default: 0
      t.timestamps
    end
    add_index :article_categories, :slug, unique: true
  end
end
