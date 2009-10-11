require 'class_options'
require 'super_simple_cms/routing'
require 'averails'
require 'super_simple_cms/super_simple'
require 'active_record/acts/list'
require 'super_simple_cms/configuration'
require 'redcloth' unless defined?(RedCloth)
ActionController::Routing::RouteSet::Mapper.send(:include, SuperSimpleCMS::Routing)

ActiveRecord::Base.send :include, ActiveRecord::Acts::Tree
ActiveRecord::Base.class_eval { include ActiveRecord::Acts::List }

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS[:setting] = '%b %d'

ActionController::Base.send(:include, SuperSimpleCms::SuperSimple) 
ActionController::Base.send(:include, SuperSimpleCms::Controllers)
ActionController::Base.view_paths = [File.join(RAILS_ROOT,'app','views'), File.join(File.dirname(__FILE__),'lib','super_simple_cms','views')]
ActionView::Base.send(:include, SuperSimpleCMS::Helpers::NavigationHelper)
ActionView::Base.send :include, TextileEditorHelper
