class Blog < ActiveRecord::Base
  extend FriendlyId
  include ActionView::Helpers::SanitizeHelper
  attr_accessible :title, :body, :permalink
  validates_uniqueness_of :permalink
  validates :title, :presence => true, :uniqueness => true
  friendly_id :permalink, use: [:slugged, :history], slug_column: :permalink
  after_create :add_first_slug
  def add_first_slug
    self.permalink = self.title
    self.save
  end

  def snippet
    strip_tags body[0..600]+'&hellip;'
  end

end
