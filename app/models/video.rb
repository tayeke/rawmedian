class Video < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :description, :permalink, :title, :vimeo_id, :tag_ids, :thumb, :preview
  has_and_belongs_to_many :tags
  validates_uniqueness_of :vimeo_id, :permalink
  friendly_id :permalink, use: [:slugged, :history], slug_column: :permalink
  after_create :add_first_slug

  def self.vimeo_videos
    require 'net/http'
    require 'json'
    accounts = Options.find_by_key(:vimeo_account).value
    return false if !accounts or accounts.empty?
    results = []
    accounts.split(',').each do |account|
      resp = Net::HTTP.get_response(URI.parse("http://vimeo.com/api/v2/#{account}/videos.json"))
      data = resp.body
      videos = JSON.parse(data)
      results |= videos
    end
    return (results.count < 1) ? false : results
  end

  def add_first_slug
    self.permalink = self.title
    self.save
  end

  def tag_ids=(tags)
    #validate if it's a new tag by not being digit
    new_tags = tags.select {|t| (t =~ /^\d/).nil? && !t.empty? }
    old_tags = tags.select {|t| !(t =~ /^\d/).nil? && !t.empty? }
    new_tags.collect! {|t| (Tag.find_or_create_by_title(:title => t).id) || nil}
    super(old_tags+new_tags)
  end

end
