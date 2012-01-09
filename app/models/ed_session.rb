class EdSession < ActiveRecord::Base
  belongs_to  :minion
  belongs_to  :school
end
