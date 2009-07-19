# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_ext] = {}
  
  Merb::BootLoader.before_app_loads do
    require File.dirname(__FILE__) + "/merb-ext/helpers.rb"
    require File.dirname(__FILE__) + "/merb-ext/other.rb"
    
    module Merb::GlobalHelpers
      include MerbExt::Helpers
    end
  end
  
end