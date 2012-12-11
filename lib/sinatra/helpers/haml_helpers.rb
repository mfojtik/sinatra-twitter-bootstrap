module Sinatra
  module Twitter
    module HAMLHelper
      def container(layout=:fixed, &block)
        @layout = layout
        haml_tag :div, :class => layout == :fixed ? :container : 'container-fluid', &block
      end

      def row(&block)
        haml_tag :div, :class => @layout == :fixed ? :row : 'row-fluid', &block
      end

      (1..12).each do |col|
        define_method "span#{col}" do |offset={}, &block|
        haml_tag :div, :class => "span#{col}#{!offset.empty? ? " offset#{offset[:offset]}" : ''}", &block
        end
      end
    end
  end
end
