class CreateGlyphs < ActiveRecord::Migration
  def change
    create_table :glyphs do |t|
      t.text :content
      t.references :user, index: true
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6

      t.timestamps null: false
    end
    add_foreign_key :glyphs, :users
    add_index :glyphs, [:user_id, :created_at]
  end
end
