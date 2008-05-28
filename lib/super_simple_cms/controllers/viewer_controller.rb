class SuperSimpleCms::Controllers::ViewerController < ApplicationController
  
  def show_group
    group = SuperSimpleCms::Group.find_by_group_name(params[:page_group])
    @page = SuperSimpleCms::Page.find(:first, :conditions=>['perma_link = ? AND group_id = ?', params[:perma_link], group.id]) if group
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
    group = SuperSimpleCms::Group.find_by_group_name("Home")
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
