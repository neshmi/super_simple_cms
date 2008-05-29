require 'super_simple_cms/routing'
require 'averails'
require 'super_simple_cms/super_simple'
require 'active_record/acts/list'
require 'redcloth' unless defined?(RedCloth)
ActionController::Routing::RouteSet::Mapper.send(:include, SuperSimpleCMS::Routing)

ActiveRecord::Base.send :include, ActiveRecord::Acts::Tree
ActiveRecord::Base.class_eval { include ActiveRecord::Acts::List }

ActionController::Base.send(:include, SuperSimpleCms::SuperSimple) 
ActionController::Base.send(:include, SuperSimpleCMS::Controllers)
ActionController::Base.send(:include, SuperSimpleCMS::Models)
ActionController::Base.view_paths.unshift(File.join(File.dirname(__FILE__), 'lib','super_simple_cms','views'))

ActionView::Base.send(:include, SuperSimpleCMS::Helpers::NavigationHelper)

