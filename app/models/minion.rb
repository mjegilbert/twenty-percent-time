class Minion < ActiveRecord::Base
  has_many :ed_sessions
  has_many :jobs
  
  attr_accessible :ed_sessions, :first_name, :last_name, :uuid, :jobs, :wid
end
