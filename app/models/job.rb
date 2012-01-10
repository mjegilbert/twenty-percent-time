class Job < ActiveRecord::Base
  belongs_to :minion
  belongs_to :company
  
  attr_accessible :minion, :company, :start_date, :end_date, :position, :text
end
