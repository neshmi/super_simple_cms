module SuperSimpleCMS::Helpers::NavigationHelper
  def super_simple_cms_links
    @links = SuperSimpleCms::Page.find(:all, :conditions=>['linkable = ?', true])
    html = ""
    @links.each do |link|
      html << "<li>#{link_to link.title.titleize, view_page_path(link.perma_link)}</li>"
    end
    return html
  end
end