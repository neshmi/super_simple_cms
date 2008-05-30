class SuperSimpleCms::Controllers::Admin::PagesController < SuperSimpleCms::Controllers::Admin::SuperSimpleController
  unloadable
  # GET /pages
  # GET /pages.xml
  def index
    @pages = SuperSimpleCms::Page.find(:all)

    respond_to do |format|
      format.html { render :template => 'admin/pages/index' }
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
    # GET /pages/1.xml
    def show
      @page = SuperSimpleCms::Page.find(params[:id])
    
      respond_to do |format|
        format.html { render :template => 'admin/pages/show' }
        format.xml  { render :xml => @page }
      end
    end
    
    # GET /pages/new
    # GET /pages/new.xml
    def new
      @page = SuperSimpleCms::Page.new
    
      respond_to do |format|
        format.html { render :template => 'admin/pages/new' }
        format.xml  { render :xml => @page }
      end
    end
    
    # GET /pages/1/edit
    def edit
      @page = SuperSimpleCms::Page.find(params[:id])
      respond_to do |format|
        format.html { render :template => 'admin/pages/edit' }
      end
    end
    
    # POST /pages
    # POST /pages.xml
    def create
      @page = SuperSimpleCms::Page.new(params[:page])
    
      respond_to do |format|
        if @page.save
          flash[:notice] = 'Page was successfully created.'
          format.html { redirect_to super_simple_page_path(@page) }
          format.xml  { render :xml => @page, :status => :created, :location => @page }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
        end
      end
    end
    
    # PUT /pages/1
    # PUT /pages/1.xml
    def update
      @page = SuperSimpleCms::Page.find(params[:id])
    
      respond_to do |format|
        if @page.update_attributes(params[:page])
          flash[:notice] = 'Page was successfully updated.'
          format.html { redirect_to super_simple_page_path(@page) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
        end
      end
    end
    
    # DELETE /pages/1
    # DELETE /pages/1.xml
    def destroy
      @page = SuperSimpleCms::Page.find(params[:id])
      @page.destroy
    
      respond_to do |format|
        format.html { redirect_to(super_simple_pages_path) }
        format.xml  { head :ok }
      end
    end
    
    def link_reset
      reset_links
      redirect_to admin_pages_path
    end
    
    def preview
      @preview = RedCloth.new(params[:body]).to_html if params[:body]
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'preview', :partial=>"admin/pages/preview", :object=>@preview  
            page.visual_effect :highlight, "preview"
          end
        end
      end
    end
end
