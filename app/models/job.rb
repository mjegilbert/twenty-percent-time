class Job < ActiveRecord::Base
  belongs_to :minion
  belongs_to :company
end
