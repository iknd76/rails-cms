# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.references :article_category, null: false, foreign_key: true
      t.string :locale, null: false, default: "en"
      t.string :title, null: false
      t.text :body, null: false
      t.string :tags, null: false, array: true, default: []
      t.integer :status, null: false, default: 0
      t.date :published_on
      t.timestamps
    end
  end
end
