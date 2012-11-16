class Video < ActiveRecord::Base
  attr_accessible :description, :permalink, :title, :vimeo_id
  has_and_belongs_to_many :tags

  def self.vimeo_videos
    require 'net/http'
    require 'json'
    account = Options.find_by_key(:vimeo_account).value
    return false if account.empty?
    resp = Net::HTTP.get_response(URI.parse("http://vimeo.com/api/v2/#{account}/videos.json"))
    data = resp.body
    videos = JSON.parse(data)
    return (videos.count < 1) ? false : videos
  end

end
