class AlterProfileStickerAddStickerStatus < ActiveRecord::Migration
  def change
    add_column :profile_stickers, :sticker_status, :integer, :default => 0, :null => false
  end
end
