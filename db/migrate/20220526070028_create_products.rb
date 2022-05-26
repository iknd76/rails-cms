# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :product_category, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.string :title_en, null: false
      t.string :title_el, null: false
      t.text :body_en, null: false
      t.text :body_el, null: false
      t.string :tags, null: false, array: true, default: []
      t.integer :status, null: false, default: 0
      t.date :published_on
      t.timestamps
    end
  end
end
