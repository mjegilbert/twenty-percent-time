class EdSession < ActiveRecord::Base
  belongs_to  :minion
  belongs_to  :school
  attr_accessible :minion, :school, :start_date, :end_date, :degree, :major, :text
end
