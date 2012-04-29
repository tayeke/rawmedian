require 'sinatra'

set :root, File.dirname(__FILE__)

def match(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end

configure :development do
  set :port, 9393
end

configure :production do
end

match '/' do
  erb :index
end

match '/vid/:id' do
  @id = params[:id]
  erb :index
end

