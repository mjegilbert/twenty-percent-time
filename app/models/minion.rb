class Minion < ActiveRecord::Base
  has_many :ed_sessions
  has_many :jobs
end
