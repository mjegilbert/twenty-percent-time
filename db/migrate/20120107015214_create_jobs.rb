class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references  :minion
      t.references  :company
      t.datetime    :start_date
      t.datetime    :end_date
      t.text      :position
      t.text      :text
      t.timestamps
    end
  end
end
