class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :atoken
      t.string      :asecret
      t.boolean     :processed
      t.timestamps
    end
  end
end
