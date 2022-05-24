# frozen_string_literal: true

class CreateSnippets < ActiveRecord::Migration[7.0]
  def change
    create_table :snippets do |t|
      t.string :slug, null: false
      t.string :title_en, null: false
      t.string :title_el, null: false
      t.text :body_en, null: false
      t.text :body_el, null: false
      t.timestamps
    end
    add_index :snippets, :slug, unique: true
  end
end
