class CreateJoinTableUsersGlyphs < ActiveRecord::Migration
  def change
    create_join_table :users, :glyphs, table_name: :view_relationships do |t|
      t.index [:user_id, :glyph_id], unique: true
      # t.index [:glyph_id, :user_id]
    end

  end
end
