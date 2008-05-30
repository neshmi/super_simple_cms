class SuperSimpleCms::Group < ActiveRecord::Base
  set_table_name 'super_simple_groups'
  
  validates_presence_of :group_name
  has_many :pages, :order=>:position
  has_many :links, :class_name => "Page", :foreign_key => "group_id", :conditions=>['linkable = ?', true], :order=>:position
  
  def validate
    
  end
  
end
