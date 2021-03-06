super_simple_cms_admin 'admin/super_simple', :controller => 'super_simple_cms/controllers/admin/super_simple', 
                                             :action => 'index'
resources :super_simple_pages, 
          :controller=>'super_simple_cms/controllers/admin/pages', 
          :member=>{:link_reset=>:get, :preview=>:put}
resources :super_simple_groups, 
          :controller=>'super_simple_cms/controllers/admin/groups', 
          :collection=>{:reorder=>:get, :show_links=>:get, :sort_links=>:post, :sort_group=>:post}

          
view_page ':perma_link', :controller => 'super_simple_cms/controllers/viewer', :action => 'show'
view_group ':page_group/:perma_link', :controller => 'super_simple_cms/controllers/viewer', :action => 'show_group'
root :controller => 'super_simple_cms/controllers/viewer'
