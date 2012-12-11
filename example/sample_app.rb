require 'sinatra/base'
require 'sinatra/twitter-bootstrap'
require 'haml'

class TestApp < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets

  use Rack::CommonLogger

  enable :inline_templates

  get '/' do
    haml :index
  end

end

TestApp.run!

__END__

@@ layout
%html
  %head
    = bootstrap_assets
  %body
    - container :fluid do
      - row do
        - span3 do
          = yield
        - span5 :offset => 4 do
          %p hello world

@@ index
%div.title Hello world.
