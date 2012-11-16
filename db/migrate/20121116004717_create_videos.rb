class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :vimeo_id
      t.string :permalink
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
