IronWorker.configure do |config|
  config.project_id = '4f0d21e6d8f74d49dc000a3e'
  config.token = 'etL0ZbwzEvo4E4fNUTvB21Ak0C8'
  
  config.database = Rails.configuration.database_configuration[Rails.env] 
end