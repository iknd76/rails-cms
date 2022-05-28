# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.references :project_category, null: false, foreign_key: true
      t.string :title_en, null: false
      t.string :title_el, null: false
      t.text :body_en, null: false
      t.text :body_el, null: false
      t.decimal :lat, null: false, precision: 10, scale: 6
      t.decimal :lng, null: false, precision: 10, scale: 6
      t.string :tags, null: false, array: true, default: []
      t.integer :status, null: false
      t.date :published_on
      t.timestamps
    end
  end
end
