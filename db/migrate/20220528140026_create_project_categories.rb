# frozen_string_literal: true

class CreateProjectCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :project_categories do |t|
      t.string :slug, null: false
      t.string :name_en, null: false
      t.string :name_el, null: false
      t.bigint :parent_id
      t.integer :position, null: false, default: 1
      t.integer :projects_count, null: false, default: 0
      t.timestamps
    end
    add_index :project_categories, :slug, unique: true
  end
end
