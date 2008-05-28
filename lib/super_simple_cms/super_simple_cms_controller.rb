class SuperSimpleCms::Lib::Averails::SuperSimpleCmsController < ActionController::Base
  before_filter :simple_authorization
  
  def index
    @pages = Averails::Page.find(:all)
    
  end
  
  def show_group
    group = SuperSimpleCMS::Group.find_by_name(params[:link_group])
    @page = SuperSimpleCMS::Page.find(:first, :conditions=>['perma_link = ? AND group_id = ?', params[:name], group.id]) if group
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
    group = SuperSimpleCMS::Group.find_by_name("Home")
    set_links(group.id)
    @page = SuperSimpleCMS::Page.find(:first, :conditions=>['perma_link = ? AND group_id = ?', params[:name], group.id])
    if @page
      @title = @page.title
      render :template => 'viewer/show'
    else
      render :file => "#{RAILS_ROOT}/public/404.html",  
      :status => 404 and return
    end
  end
  
  protected
  def simple_authorization
    # if SuperSimpleCMS.config.authorization.is_a? Proc
    #   instance_eval &SuperSimpleCMS.config.authorization
    # elsif SuperSimpleCMS.config.authorization.is_a? Symbol
    #   send(SuperSimpleCMS.config.authorization)
    # elsif defined? authorize
    #   authorize
    # else
    #   true
    # end
  end
  
end 

