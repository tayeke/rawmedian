require 'sinatra'
require 'redis'

set :root, File.dirname(__FILE__)

def match(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end

configure :development do
  set :port, 9393
  REDIS = Redis.new
end

configure :production do
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

configure do

end

before do
  @videos = videos()
end

match '/' do
  erb :index
end

match '/vid/:id' do
  @id = params[:id]
  erb :index
end

def video _id
  require 'json'
  if !REDIS.get(_id) # cache check
    require 'net/http'
    resp = Net::HTTP.get_response(URI.parse("http://vimeo.com/api/v2/video/#{_id}.json"))
    data = resp.body
    video = JSON.parse(data)
    REDIS.set(_id, video.to_json)
    REDIS.expire(_id, 43200)
  end
  return JSON.parse(REDIS.get(_id))
end

def videos
  require 'json'
  if !REDIS.get('videos') # cache check
    require 'net/http'
    resp = Net::HTTP.get_response(URI.parse("http://vimeo.com/api/v2/10064211/videos.json"))
    data = resp.body
    videos = JSON.parse(data)
    REDIS.set('videos', videos.to_json)
    REDIS.expire('videos', 43200)
  end
  return JSON.parse(REDIS.get('videos'))
end
