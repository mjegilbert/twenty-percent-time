class ConnectionWorker < IronWorker::Base
  merge_gem "activerecord", :require => "active_record"
  merge_gem "linkedin"
  merge_folder "../models/"
  
  attr_accessor :asecret, :atoken

  def construct_date(month, year)
    month = 1 if month.nil?
    
    if year.nil?
      return nil
    else 
      return DateTime.new(year.to_i, month.to_i)
    end
  end
  
  # The run method is what IronWorker calls to run your worker
  def run
    client = LinkedIn::Client.new('4wkfc3lzk92h', '7C2BKYvq04X3K2hB')
    client.authorize_from_access(atoken, asecret)
    connection_mash = client.connections(:fields =>["id", "first-name", "last-name", "phone-numbers", "main-address","positions", "educations", "honors", "associations", "interests", "picture-url"])["all"]
    
    connection_mash.each do |person|
      # Create new minion if it does not already exist in the database by UUID
      uuid = person["id"]
      log "Grabbing #{uuid}: #{person['first_name']} #{person['last_name']}"
      if !Minion.find_by_uuid(uuid) && uuid != "private"
        minion = Minion.new(:first_name => person["first_name"],
                            :last_name => person["last_name"],
                            :uuid => uuid)
        minion.save
        
        # School  
        educations = person["educations"]["all"]
        if educations
          educations.each do |ed|
            
            start_date = construct_date(ed["start_date"]["month"], ed["start_date"]["year"]) rescue nil
            end_date = construct_date(ed["end_date"]["month"], ed["end_date"]["year"]) rescue nil
            e = EdSession.new(:start_date => start_date, :end_date => end_date)
            e.minion_id = minion.id
            
            existing = School.find_by_name(ed["school_name"])
            if existing
              e.school_id = existing.id
            else
              new_school = School.new(:name => ed["school_name"])
              new_school.save
              e.school_id = new_school.id
            end
              
            e.save
          end
        end
  
        # Jobs
        positions = person["positions"]["all"]
        if positions
          positions.each do |pos|
            
            start_date = construct_date(pos["start_date"]["month"], pos["start_date"]["year"]) rescue nil
            end_date = construct_date(pos["end_date"]["month"], pos["end_date"]["year"]) rescue nil
            
            p = Job.new(:start_date => start_date, :end_date => end_date, :position => pos["title"], :text => pos["summary"])
            p.minion_id = minion.id
            
            # Assign to company
            existing = Company.find_by_name(pos["company"]["name"])
            if existing
              p.company_id = existing.id
            else
              new_company = Company.new(:name => pos["company"]["name"])
              new_company.save
              p.company_id = new_company.id
            end        
          
            p.save                    
          end
        end
      end
    end
  end
end