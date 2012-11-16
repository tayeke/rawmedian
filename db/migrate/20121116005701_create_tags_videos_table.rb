class CreateTagsVideosTable < ActiveRecord::Migration
  def up
    create_table :tags_videos, :id => false do |t|
      t.integer :tag_id
      t.integer :video_id
    end
  end

  def down
    drop_table :tags_videos
  end
end
