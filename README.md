Sinatra Bootstrap (css+js+helpers)
=================

What?
--------

A set of helpers that brings beauty of Bootstrap CSS to your Sinatra
applications. This gem bundle all CSS and Javascript files needed for this.

Why?
--------

I want to make my small Sinatra apps looks nice with minimal effort. Currently
I need to download all CSS and Javascript, add them to public folder and include
them in HAML templates. That is just too much work!

How?
--------

Is simple. Add this line to your Gemfile:

    gem 'sinatra-twitter-bootstrap', :require => 'sinatra/twitter-bootstrap'
    
or without bundler, `gem install sinatra-twitter-bootstrap` and then: 

    require 'sinatra/twitter-bootstrap'

Then in your Sinatra application/class you can do:

    class TestApp < Sinatra::Base
      register Sinatra::Twitter::Bootstrap::Assets
    end

(TODO: make this a bit shorter)

Now, surprise surprise! Your application will automatically generate routes for
bootstrap CSS and JS files. It will also setup HTTP caching and ETags, so it
will not be too much overheat for your app.

Since I'm old and lazy, I create small helpers you can use in your HAML views:

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


The full example could be found in 'examples' directory.


License
--------

This code is licensed under Apache Software License (ASLv2)
http://www.apache.org/licenses/LICENSE-2.0.txt

Bootstrap is licenced under Apache Software License (ASL)
http://www.apache.org/licenses/LICENSE-2.0.txt

JQuery is licenced under MIT license.
HTML5 Shiv is licenced under MIT/GPL2 (https://github.com/aFarkas/html5shiv)
