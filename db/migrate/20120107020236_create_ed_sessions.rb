class CreateEdSessions < ActiveRecord::Migration
  def change
    create_table :ed_sessions do |t|
      t.references  :minion
      t.references  :school
      t.datetime    :start_date
      t.datetime    :end_date
      t.string      :degree
      t.string      :major
      t.string      :text
      t.timestamps
    end
  end
end
