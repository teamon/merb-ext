module MerbExt
  module Helpers
    def default_error_messages_for(obj, opts = {})
      error_messages_for obj, :build_li => "<li>%s</li>", :header => "<h3>#{"Oops! There are some errors:".t}</h3>"
    end
    
    def fieldset(attrs = {}, &blk)
      legend = (l_attr = attrs.delete(:legend)) ? tag(:h2, l_attr) : ""
      legend + super
    end
    
    def link_to_unless(condition, label, *args, &block)
      link_to_if !condition, label, *args, &block
    end
    
    def link_to_if(condition, label, *args, &block)
      if condition
        link_to(label, *args, &block)
      else
        tag(:span, label)
      end
    end
    
    def number_with_delimiter(number, delimiter = ".")
      number.to_s.reverse.scan(/.{1,3}/).join(delimiter).reverse
    end

    def truncate(text, max_length)
      return text[0, max_length] + "..." if text.length > max_length
      text
    end

    def colorize(var, format = nil)
      color = if var.is_a?(Numeric)
        var >= 0 ? :green : :red
      else
        var ? :green : :red
      end

      var = format % var if format
      '<span style="color: %s">%s</span>' % [color, var]
    end
    
    require 'digest/md5'
    def gravatar_url_for(email, opts = {})
      opts[:default] = "http://#{request.host}/images/#{opts[:default]}" if opts[:default]
      "http://www.gravatar.com/avatar.php/#{Digest::MD5.hexdigest(email || "")}?#{opts.to_params}"
    end

    def gravatar_image_for(email, opts = {})
      image_tag(gravatar_url_for(email, opts), :alt => "")
    end
    
    def put_button(*args, &block)
      js_button(:put, *args, &block)
    end
    
    def post_button(*agrs, &block)
      js_button(:post, *args, &block)
    end
    
    def delete_button(*args, &block)
      js_button(:delete, *args, &block)
    end
    
    def js_button(method, label, url, attrs = {}, &block)
      tag :form, :class => "#{method}-btn btn", :action => url, :method => :post do
        tag(:input, :type => :hidden, :name => "_method", :value => method.to_s) <<
        tag(:input, attrs.merge(:value => label, :type => :submit))
      end
    end
  end
end