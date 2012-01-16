namespace :thaisan do
  desc "Dump dat shit"
  task :dump => :environment do
    puts "=-=-=-=- Dump database into csv file -=-=-=-="

    file = File.new("dump.csv", "w+")
    
    # Write file header
    file.puts "uuid, first_name, last_name, company, position, start, end"
    
    Minion.all.each do |minion|        
      minion.jobs.each do |j|
        stuff = [
                  minion.uuid,
                  minion.first_name,
                  minion.last_name,
                  j.company.name,
                  j.position,
                  j.start_date,
                  j.end_date,
                ]
        file.puts stuff.join(", ")
      end
      minion.ed_sessions.each do |e|
        stuff = [
                  minion.uuid,
                  minion.first_name,
                  minion.last_name,
                  e.school.name,
                  e.start_date,
                  e.end_date,
                ]
        file.puts stuff.join(", ")
      end
    end
    file.close
  end
end