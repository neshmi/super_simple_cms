require 'super_simple_cms/routing'
require 'averails'
require 'active_record/acts/list'
require 'redcloth' unless defined?(RedCloth)

ActiveRecord::Base.send :include, ActiveRecord::Acts::Tree
ActiveRecord::Base.class_eval { include ActiveRecord::Acts::List }
ActionController::Base.send(:include, SuperSimpleCMS::Controllers)
ActionController::Base.send(:include, SuperSimpleCMS::Models)
ActionView::Base.send(:include, SuperSimpleCMS::Helpers::NavigationHelper)

ActionController::Routing::RouteSet::Mapper.send(:include, SuperSimpleCMS::Routing)
ActionController::Base.view_paths.unshift(File.join(File.dirname(__FILE__), 'lib','super_simple_cms','views'))
