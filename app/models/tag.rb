class Tag < ActiveRecord::Base
  attr_accessible :title
  has_many_and_belongs_to :videos
end
