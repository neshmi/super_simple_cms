class SuperSimpleCms::Controllers::Admin::GroupsController < SuperSimpleCms::Controllers::Admin::SuperSimpleController
  unloadable
  # GET /groups
  # GET /groups.xml
  def index
    @groups = SuperSimpleCms::Group.find(:all, :order=>:position)

    respond_to do |format|
      format.html { render :template => 'admin/groups/index' }
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = SuperSimpleCms::Group.find(params[:id])

    respond_to do |format|
      format.html { render :template=>'admin/groups/show' }
      format.js { render :template=>'admin/groups/show', :layout=>false}
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = SuperSimpleCms::Group.new

    respond_to do |format|
      format.html {render :template=>'admin/groups/new'}
      format.js {render :template=>'admin/groups/new', :layout=>false}
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = SuperSimpleCms::Group.find(params[:id])
    respond_to do |format|
       format.html {render :template=>'admin/groups/edit'}
       format.js {render :template=>'admin/groups/edit', :layout=>false}
     end
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = SuperSimpleCms::Group.new(params[:group])

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to super_simple_group_path(@group) }            
        format.js   { redirect_to formatted_super_simple_group_path(@group, :js) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.js   { render :action => "new", :layout=>false}
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = SuperSimpleCms::Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to super_simple_group_path(@group) }            
        format.js   { redirect_to formatted_super_simple_group_path(@group, :js) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.js   { render :action => "new", :layout=>false}
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = SuperSimpleCms::Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(super_simple_groups_url) }
      format.js { head :ok }
      format.xml  { head :ok }
    end
  end
  
  def show_links
    @group = SuperSimpleCms::Group.find(params[:id])
    @group_links = @group.links
    
    render :template=>'admin/groups/show_links', :layout=>false
  end
  
  def reorder
    @groups = SuperSimpleCms::Group.find(:all, :order=>'position')
    respond_to do |format|
      format.html 
      format.js { render :template=>'admin/groups/reorder', :layout => false }
      format.xml  { render :xml => @groups }
    end
  end
  
  def sort_group
    @groups = SuperSimpleCms::Group.find(:all)
    @groups.each do |group|
      group.position = params['groups_reorder'].index(group.id.to_s) + 1
      group.save
    end
    render :nothing => true
  end
  
  def sort_links
    @pages = SuperSimpleCms::Page.find(:all, :conditions=>['group_id = ?', params[:group_id]])
    @pages.each do |page|
      page.position = params['groups_reorder'].index(page.id.to_s) + 1
      page.save
    end
    render :nothing => true
  end
  
end
