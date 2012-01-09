class CreateMinions < ActiveRecord::Migration
  def change
    create_table :minions do |t|
      t.string    :first_name
      t.string    :last_name
      t.string    :uuid
      t.timestamps
    end
  end
end
