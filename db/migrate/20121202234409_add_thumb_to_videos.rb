class AddThumbToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :thumb, :string
  end
end
