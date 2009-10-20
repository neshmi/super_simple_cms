class SuperSimpleCms::Page < ActiveRecord::Base
  
  set_table_name 'super_simple_pages'

  belongs_to :group, :class_name => "SuperSimpleCms::Group"  
  
  acts_as_list :scope => :group
  
  validates_presence_of :title, :body
  validates_uniqueness_of :title, :scope=>:group_id
  validates_uniqueness_of :perma_link, :scope=>:group_id
  
  def self.find_for_sitemap
    find(:all, :select=>'id, updated_at, perma_link', :order=>'updated_at DESC', :limit=>50000)
  end
  
  def before_save
    self.html = RedCloth.new(self.body).to_html if self.body
    if self.perma_link.nil? || self.perma_link.length < 1
      self.perma_link = self.title.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-') 
    end
    self.perma_link = self.perma_link.gsub(/[^[:alnum:]]/,'-').gsub(/-{2,}/,'-')
    self.perma_link.downcase!
  end
  
end
