class AddPreviewToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :preview, :string
  end
end
