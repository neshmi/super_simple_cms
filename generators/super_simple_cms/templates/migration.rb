class CreateSuperSimpleCms < ActiveRecord::Migration
  def self.up
    create_table :super_simple_pages, :force => true do |t|
      t.text :body, :html
      t.string :perma_link, :title
      t.boolean :linkable
      t.integer :group_id, :position
      t.timestamps
    end
    
    create_table :super_simple_groups, :force => true do |t|
      t.string :group_name
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :super_simple_pages
    drop_table :super_simple_groups
  end
end
