class Tag < ActiveRecord::Base
  attr_accessible :title
  has_and_belongs_to_many :videos
  validates :title, :presence => true, :uniqueness => true

end
