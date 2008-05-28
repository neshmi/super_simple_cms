class SuperSimpleCms::Controllers::Admin::SuperSimpleController < ApplicationController
  def index
    render :template => 'admin/super_simple/index'
  end
end
