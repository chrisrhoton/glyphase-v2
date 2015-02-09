class AddImageAttachmentToGlyphs < ActiveRecord::Migration
  def change
    add_column :glyphs, :image_attachment, :string
  end
end
