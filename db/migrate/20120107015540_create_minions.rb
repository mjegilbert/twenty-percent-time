class CreateMinions < ActiveRecord::Migration
  def change
    create_table :minions do |t|
      t.string    :name
      t.string    :uuid
      t.timestamps
    end
  end
end
