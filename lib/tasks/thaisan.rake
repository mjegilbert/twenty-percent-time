namespace :thaisan do
  desc "Grab dat shit into da database"
  task :grab => :environment do
    User.all.each do |user|
      puts "=-=-=-=- Grabbing #{user.first_name} #{user.last_name}'s connections -=-=-=-="
      worker = ConnectionWorker.new
      worker.atoken = user.atoken
      worker.asecret = user.asecret
      worker.run_local
    end
  end
  
  desc "Dump dat shit"
  task :dump => :environment do
    puts "=-=-=-=- Dump database into csv file -=-=-=-="

    # Jobs
    file = File.new("job_data.csv", "w+")
    
    # Write file header
    file.puts "uuid, company, position, start, end"
    
    Minion.all.each do |minion|        
      minion.jobs.each do |j|
        stuff = minion.uuid.to_s + ", " 
        stuff += j.company.name.gsub(",", "") rescue ""
        stuff += ", " + j.position.gsub(",", "") rescue ""
        stuff += ", " + j.start_date.to_s + ", " + j.end_date.to_s
        file.puts stuff
      end
    end
    file.close
    
    
    # Education
    file = File.new("education_data.csv", "w+")
    
    # Write file header
    file.puts "uuid, school, start, end"
    
    Minion.all.each do |minion|
      minion.ed_sessions.each do |e|
        stuff = minion.uuid.to_s + ", " 
        stuff += e.school.name.gsub(",", "") rescue ""
        stuff += ", " + e.start_date.to_s + ", " + e.end_date.to_s
        file.puts stuff
      end
    end
    file.close
  end
end