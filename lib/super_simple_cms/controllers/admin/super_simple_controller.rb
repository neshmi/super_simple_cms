class SuperSimpleCms::Controllers::Admin::SuperSimpleController < ApplicationController
  unloadable
  before_filter :handle_authorization  
  before_filter :handle_layout
  def index
    render :template => 'admin/super_simple/index'
  end
  
  protected
  
  def handle_authorization
    if SuperSimpleCms.config.admin_authorization.is_a? Proc
      instance_eval &SuperSimpleCms.config.admin_authorization
    elsif SuperSimpleCms.config.admin_authorization.is_a? Symbol
      send(SuperSimpleCms.config.admin_authorization)
    elsif defined? admin_authorization
      admin_authorization
    else
      true
    end
  end
  
  def handle_layout
    debugger
  end
  
  SuperSimpleCms.config.admin_includes.each do |mod|
    mod_klass = if mod.is_a? String
      mod.constantize
    elsif mod.is_a? Symbol
      mod.to_s.classify.constantize
    else
      mod
    end
    include mod_klass
  end
  
end
