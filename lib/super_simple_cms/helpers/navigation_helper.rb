module SuperSimpleCMS::Helpers::NavigationHelper
  
  def super_simple_cms_links(css_class = nil)
    html = ""
    
    if @links && @links.length > 0
      if @links.first.group != SuperSimpleCms::Group.find(:first, :order=>'position')
        @links.each do |link|
          html << "<li class='#{css_class}'>#{link_to link.title, view_group_path(:page_group=>link.group.group_name, :perma_link=>link.perma_link)}</li>"
        end
      else
        @links.each do |link|
          html << "<li class='#{css_class}'>#{link_to link.title, view_page_path(link.perma_link)}</li>"
        end
      end
    end
    
    if @group_links && !@group_links.empty?
      @group_links.each do |group_link|
        html << "<li class='#{css_class}'>#{link_to group_link.group.spaced_name, view_group_path(:page_group=>group_link.group.group_name, :perma_link=>group_link.perma_link) if @links.first.group != group_link.group}</li>"
      end
    end

    return html
  end
  
  def super_simple_main_links(*opts)
    optiions = opts.first
    optiions[:element] ? element = "#{optiions[:element]}" : element = "li"
    optiions[:class] ? css_class = "#{optiions[:class]}" : css_class = "" 
    
    groups = SuperSimpleCms::Group.find(:all, :order=>'position')
    
    html = ""
    if groups && !groups.empty?
      groups.each do |group|
        html << "<#{element} class='#{css_class}'>#{link_to group.spaced_name, view_group_path(:page_group=>group.group_name, :perma_link=>group.links.first.perma_link)}</#{element}>" if group.links.length > 0
      end
    end
    return html
  end
  
  def super_simple_sub_links(group,*opts)
    options = opts.first
    options[:element] ? element = "#{options[:element]}" : element = "li"
    options[:class] ? css_class = "#{options[:class]}" : css_class = ""
    html = ""
    group.links.each{|link| html << "<#{element} class='#{css_class}'>#{link_to link.title, view_group_path(:page_group=>group.group_name, :perma_link=>link.perma_link)}</#{element}>"} if group.links.length > 1
    return html
  end
  
end
