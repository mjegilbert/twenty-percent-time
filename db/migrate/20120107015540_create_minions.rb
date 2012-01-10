class CreateMinions < ActiveRecord::Migration
  def change
    create_table :minions do |t|
      t.text    :first_name
      t.text    :last_name
      t.text    :uuid
      t.timestamps
    end
  end
end
