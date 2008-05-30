#Thanks to Matt McCray of the famouse Comatose plugin for the template for configuring this plugin.  Great work!
module SuperSimpleCms

  def self.config
    @@config ||= Configuration.new
  end

  def self.configure(&block)
    raise "#configure must be sent a block" unless block_given?
    yield config
  end

  class Configuration

    attr_accessor_with_default :admin_title,          'Comatose'
    attr_accessor_with_default :admin_includes,       []
    attr_accessor_with_default :admin_helpers,        []
    attr_accessor_with_default :admin_sub_title,      'The Micro CMS'
    attr_accessor_with_default :content_type,         'utf-8'
    attr_accessor_with_default :default_filter,       'Textile'
    attr_accessor_with_default :default_processor,    :liquid
    attr_accessor_with_default :default_tree_level,   2
    attr_accessor_with_default :disable_caching,      false
    attr_accessor_with_default :hidden_meta_fields,   []
    attr_accessor_with_default :helpers,              []
    attr_accessor_with_default :includes,             []

    # A 'blockable' setters
    blockable_attr_accessor    :authorization
    blockable_attr_accessor    :admin_authorization
    blockable_attr_accessor    :admin_get_author
    blockable_attr_accessor    :admin_get_root_page
    blockable_attr_accessor    :after_setup

    def initialize
      # Default procs for blockable attrs....
      @authorization       = Proc.new { true }
      @admin_authorization = Proc.new { true }
      @admin_get_author    = Proc.new { request.env['REMOTE_ADDR'] }
      @admin_get_root_page = Proc.new { Comatose::Page.root }
      @after_setup         = Proc.new { true }
    end
    
    class ConfigurationError < StandardError; end
    
  end

end