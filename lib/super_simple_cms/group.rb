class SuperSimpleCms::Group < ActiveRecord::Base
  set_table_name 'super_simple_groups'
  
  validates_presence_of :group_name
  has_many :pages, :class_name => "SuperSimpleCms::Page", :order=>:position, :dependent=>:destroy
  has_many :links, :class_name => "SuperSimpleCms::Page", :foreign_key => "group_id", :conditions=>['linkable = ?', true], :order=>:position
  
  def validate
    
  end

  def spaced_name
    self.group_name.gsub("_"," ")
  end

  def self.update
    SuperSimpleCms::Group.all.each do |group|
      group.group_name = group.group_name.gsub(" ","_")
      group.save
    end
  end

  def before_save
    self.group_name.gsub!(" ","_")
  end
  
end
