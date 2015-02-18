class AddIdToViewRelationships < ActiveRecord::Migration
  def change
    add_column :view_relationships, :id, :primary_key
  end
end
