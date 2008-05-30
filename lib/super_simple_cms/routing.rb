module SuperSimpleCMS
  module Routing
    def super_simple_cms 
      plugin_root = File.join(RAILS_ROOT, 
                              'vendor', 
                              'plugins') 
      routes_path = File.join(plugin_root, 
                              'super_simple_cms', 
                              'routes.rb') 
      if File.file?(routes_path) 
        eval(IO.read(routes_path), binding, routes_path) 
      end 
    end 
  end 
end
