class AddHeaderImageToGlyphs < ActiveRecord::Migration
  def change
    add_column :glyphs, :header_image, :string, default: nil
  end
end
