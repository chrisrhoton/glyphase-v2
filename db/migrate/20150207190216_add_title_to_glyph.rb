class AddTitleToGlyph < ActiveRecord::Migration
  def change
    add_column :glyphs, :title, :string
  end
end
