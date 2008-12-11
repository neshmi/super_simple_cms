class SuperSimpleCms::Controllers::ViewerController < ApplicationController
  unloadable
  def index
    @current_group = SuperSimpleCms::Group.find(:first, :order=>'position')
    # set_links(group.id)
    @page = SuperSimpleCms::Page.find(:first, :conditions=>['group_id = ? AND position = ?', @current_group.id, 1])
    if @page
      @title = @page.title
      render :template => 'viewer/show'
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
      render :template => 'viewer/show'
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
      render :template => 'viewer/show'
    else
      render :file => "#{RAILS_ROOT}/public/404.html",  
      :status => 404 and return
    end
  end
  
end
