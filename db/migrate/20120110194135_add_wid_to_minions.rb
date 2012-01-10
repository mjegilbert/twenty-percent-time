class AddWidToMinions < ActiveRecord::Migration
  def up
    add_column :minions, :wid, :integer
  end
  
  def down
    remove_column :minions, :wid    
  end
end
