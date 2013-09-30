require_relative './helpers/haml_helpers'

module Sinatra
  module Twitter
    module Bootstrap

      module Assets

        ASSETS = {
          :css => [
            ['bootstrap.min.css', 'a5cee949f15193b2e2f9aa7275051dea69d0eea1'],
            ['bootstrap-responsive.min.css', '68e924c9fcbee3cb5d47ca6d284fb3eec82dd304'],
          ],
          :png => [
            ['glyphicons-halflings.png', '84f613631b07d4fe22acbab50e551c0fe04bd78b'],
            ['glyphicons-halflings-white.png', '9bbc6e9602998a385c2ea13df56470fd']
          ],
          :js => [
            ['jquery.min.js', '8b6babff47b8a9793f37036fd1b1a3ad41d38423'],
            ['bootstrap.min.js', '3e6ab2b64de4239acb763383a591d76a44053293'],
            ['html5.js', 'c9d8ca77abcd9789b91b4c3263f257e1fc1ee103']
          ],
        }

        def self.generate_bootstrap_asset_routes(app)
          ASSETS.each do |kind, files|
            files.each do |file|
              name, sha1 = file
              kind_route = (kind == :png) ? :img : kind
              app.get '/%s/%s' % [kind_route.to_s, name], :provides => kind do
                cache_control :public, :must_revalidate, :max_age => 3600
                etag sha1
                File.read(File.join(File.dirname(__FILE__), 'assets', name))
              end
            end
          end
        end

        def self.registered(app)
          generate_bootstrap_asset_routes(app)
          app.helpers AssetsHelper
          app.helpers HAMLHelper
        end

      end

      module AssetsHelper

        def bootstrap_css
          output = '<meta name="viewport" content="width=device-width, initial-scale=1.0">'
          Assets::ASSETS[:css].each do |file, _|
            output += '<link rel="stylesheet" media="screen, projection" type="text/css" href="%s">' % url('/css/%s' % file)
          end
          output
        end

        def bootstrap_js
          output = ''
          Assets::ASSETS[:js].each do |file, _|
            output += '<!--[if lt IE 9]>' if file == 'html5.js'
            output += '<script type="text/javascript" src="%s"></script>' % url('/js/%s' % file)
            output += '<![endif]-->' if file == 'html5.js'
          end
          output
        end

        def bootstrap_assets
          bootstrap_css + bootstrap_js
        end

      end
    end
  end
end
