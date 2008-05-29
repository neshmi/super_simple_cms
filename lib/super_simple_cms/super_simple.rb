module SuperSimpleCms
  module SuperSimple 
  
    def self.included(base) 
      base.extend ClassMethods 
      base.before_filter :set_home_links, :set_group_links 
    end 
  
    module ClassMethods 
    end 
  
    private 
  
    def set_home_links
      group = SuperSimpleCms::Group.find_by_group_name('Home')
      set_links(group.id)
    end
  
    def set_links(group_id)    
      if @links && @links.first.group_id != group_id
        reset_links
      end
      @links ||= SuperSimpleCms::Page.find(:all, :conditions=>['group_id = ? AND linkable = ?', group_id, true], :order=>:position)
    end
    
    def set_group_links
      @group_links = []
      
      if params[:page_group]
        SuperSimpleCms::Group.find(:all, :order=>:position).each do |group|
          @group_links << group.pages.first if group.pages.length > 0 && group.group_name != params[:page_group] && group.pages.first.linkable?
        end
      else
        SuperSimpleCms::Group.find(:all, :order=>:position).each do |group|
          @group_links << group.pages.first if group.pages.length > 0 && group.group_name != 'Home' && group.pages.first.linkable?
        end
      end
    end

    def reset_links
      @links = nil
    end
    
  end 
end 
