class AddTaglineToGlyph < ActiveRecord::Migration
  def change
    add_column :glyphs, :tagline, :string
  end
end
