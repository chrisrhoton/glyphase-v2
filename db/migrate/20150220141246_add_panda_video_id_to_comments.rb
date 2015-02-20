class AddPandaVideoIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :panda_video_id, :string, default: ""
  end
end
