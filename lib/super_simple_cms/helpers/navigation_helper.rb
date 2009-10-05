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
    options = opts.first
    options[:element] ? element = "#{options[:element]}" : element = "li"
    options[:class] ? css_class = "#{options[:class]}" : css_class = "" 
    options[:selected] ? selected = "#{options[:selected]}" : selected = ""
    
    groups = SuperSimpleCms::Group.find(:all, :order=>'position')
    
    html = ""
    if groups && !groups.empty?
      groups.each do |group|
        params[:page_group] == group.group_name ? selected_class = selected : selected_class = ""
        html << "<#{element} class='#{css_class} #{selected_class}'>#{link_to group.spaced_name, view_group_path(:page_group=>group.group_name, :perma_link=>group.links.first.perma_link)}</#{element}>" if group.links.length > 0
      end
    end
    return html
  end
  
  def super_simple_sub_links(group,*opts)
    options = opts.first
    options[:element] ? element = "#{options[:element]}" : element = "li"
    options[:class] ? css_class = "#{options[:class]}" : css_class = ""
    options[:selected] ? selected = "#{options[:selected]}" : selected = ""
    html = ""
    if group.links.length > 1
      group.links.each do |link| 
        params[:perma_link] == link.perma_link ? selected_class = selected : selected_class = ""
        html << "<#{element} class='#{css_class} #{selected_class}'>#{link_to link.title, view_group_path(:page_group=>group.group_name, :perma_link=>link.perma_link)}</#{element}>" 
      end
    end
    return html
  end
  
  def super_simple_nested_links(*opts)
    ul_id = "menu_ul"
    ul_class = "ul_class"
    sub_li = "sub_li"
    sub_menu_class = "sub_menu"
    unless opts.empty?
      options = opts.first
      ul_id = options[:ul_id] if options[:ul_id]
      ul_class = options[:ul_class] if options[:ul_class]
      sub_menu_class = options[:sub_menu_class] if options[:sub_menu_class]
    end 
    html = ""    
    groups = SuperSimpleCms::Group.find(:all, :order=>'position')
    html << "<ul id ='#{ul_id}' class='#{ul_class}'>"
    
    if groups && !groups.empty?    
      groups.each do |group|
        if !group.links.empty? && group.links.length > 1
          html << "<li class=#{sub_li}>"        
          html << "#{link_to group.spaced_name, view_group_path(:page_group=>group.group_name, :perma_link=>group.links.first.perma_link), :class=>sub_menu_class}"
          html << "<ul>"        
          group.links.each do |link|
            html << "<li>#{link_to link.title, view_group_path(:page_group=>group.group_name, :perma_link=>link.perma_link)}</li>"
          end
          html << "</ul>"
          html << "</li>"        
        elsif !group.links.empty?
          html << "<li>"        
          html << "#{link_to group.spaced_name, view_group_path(:page_group=>group.group_name, :perma_link=>group.links.first.perma_link)}"
          html << "</li>"
        else
          html << ""
        end
      end
    end    
    
    html << "</ul>"
    
  end
  
end
