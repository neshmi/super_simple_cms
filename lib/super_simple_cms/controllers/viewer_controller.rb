class SuperSimpleCms::Controllers::ViewerController < ApplicationController
  unloadable
  def index
    @current_group = SuperSimpleCms::Group.find(:first, :order=>'position')
    # set_links(group.id)
    @page = SuperSimpleCms::Page.find(:first, :conditions=>['group_id = ? AND position = ?', @current_group.id, 1])
    if @page
      @title = @page.title
      file_to_render = File.join(RAILS_ROOT,'app','views',@current_group.group_name,'show.erb')
      if File.exist?(file_to_render)
        render :template=>file_to_render
      else
        render :template => 'viewer/show'
      end
    else
      render :file => "#{RAILS_ROOT}/public/404.html",  
      :status => 404 and return
    end
  end
  
  def show_group
    group = SuperSimpleCms::Group.find_by_group_name(params[:page_group])
    @page = SuperSimpleCms::Page.find(:first, 
                                      :conditions=>['perma_link = ? AND group_id = ?', params[:perma_link], group.id],  
                                      :order=>'position') if group
    if @page
      @title = @page.title
      set_links(group.id)
      file_to_render = File.join(RAILS_ROOT,'app','views',group.group_name,'show.erb')
      if File.exist?(file_to_render)
        render :template=>"#{group.group_name}/show.erb"
      else
        render :template => 'viewer/show'
      end
    else
      render :file => "#{RAILS_ROOT}/public/404.html",  
      :status => 404 and return
    end
  end
  
  def show
    group = SuperSimpleCms::Group.find(:first, :order=>'position')
    # set_links(group.id)
    @page = SuperSimpleCms::Page.find(:first, :conditions=>['perma_link = ? AND group_id = ?', params[:perma_link], group.id])
    if @page
      @title = @page.title
      file_to_render = File.join(RAILS_ROOT,'app','views',group.group_name,'show.erb')
      if File.exist?(file_to_render)
        render :template=>file_to_render
      else
        render :template => 'viewer/show'
      end
    else
      render :file => "#{RAILS_ROOT}/public/404.html",  
      :status => 404 and return
    end
  end
  
end
