class Video < ActiveRecord::Base
  attr_accessible :description, :permalink, :title, :vimeo_id
  has_many_and_belongs_to :tags
end
