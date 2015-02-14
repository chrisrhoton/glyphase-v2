class AddImageAttachmentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :image_attachment, :string
  end
end
