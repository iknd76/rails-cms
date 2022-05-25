# frozen_string_literal: true

class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name, null: false
      t.string :website, null: false
      t.integer :products_count, null: false, default: 0
      t.timestamps
    end
  end
end
