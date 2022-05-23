# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :trackable, null: false, polymorphic: true
      t.string :trackable_name, null: false
      t.string :action, null: false
      t.timestamps
    end
  end
end
