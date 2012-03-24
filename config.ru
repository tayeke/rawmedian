use Rack::Static, 
  :urls => ["/stylesheets", "/images", "/javascripts"],
  :root => "public"

run lambda { |env|
  [
    200, 
    {
      'Content-Type'  => 'text/html', 
      'Cache-Control' => '., max-age=86400' 
    },
    File.open('public/index.htm', File::RDONLY)
  ]
}