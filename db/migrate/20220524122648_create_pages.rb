# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :slug, null: false
      t.string :title_en, null: false
      t.string :title_el, null: false
      t.text :body_en, null: false
      t.text :body_el, null: false
      t.text :description_en
      t.text :description_el
      t.text :keywords_en
      t.text :keywords_el
      t.timestamps
    end
    add_index :pages, :slug, unique: true
  end
end
