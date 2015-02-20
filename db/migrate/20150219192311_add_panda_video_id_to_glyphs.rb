class AddPandaVideoIdToGlyphs < ActiveRecord::Migration
  def change
    add_column :glyphs, :panda_video_id, :string
  end
end
