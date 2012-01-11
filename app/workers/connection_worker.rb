class ConnectionWorker < IronWorker::Base
  merge_gem "activerecord", :require => "active_record"
  merge_gem "linkedin"
  merge_folder "../models/"
  
  attr_accessor :asecret, :atoken

  def run
    user = User.new(:atoken => atoken, :asecret => asecret)
    user.save
  end
  
  # # The run method is what IronWorker calls to run your worker
  # def run
  #   user_files = %x[ls #{user_dir.inspect}]
  #   log "#{user_files}"
  #   
  #   client = LinkedIn::Client.new('4wkfc3lzk92h', '7C2BKYvq04X3K2hB')
  #   client.authorize_from_access(atoken, asecret)
  #   connection_mash = client.connections(:fields =>["id", "first-name", "last-name", "phone-numbers", "main-address","positions", "educations", "honors", "associations", "interests", "picture-url"])["all"]
  #   
  #   connection_mash[1..3].each do |person|
  #     # Create new minion if it does not already exist in the database by UUID
  #     uuid = person["id"]
  #     log uuid
  #     if !Minion.find_by_uuid(uuid)
  #       minion = Minion.new(:first_name => person["first_name"],
  #                           :last_name => person["last_name"],
  #                           :uuid => uuid)
  #       minion.save
  #       
  #       # # School  
  #       # educations = person["educations"]["all"]
  #       # if educations
  #       #   educations.each do |ed|
  #       #     #e = EdSession.new(:start_date => ed["start_date"]["year"], :end_date => ed["end_date"]["year"])
  #       #     e = EdSession.new
  #       #     e.minion_id = minion.id
  #       # 
  #       #     existing = School.find_by_name(ed["school_name"])
  #       #     if existing
  #       #       e.school_id = existing.id
  #       #     else
  #       #       new_school = School.new(:name => ed["school_name"])
  #       #       new_school.save
  #       #       e.school_id = new_school.id
  #       #     end
  #       #       
  #       #     e.save
  #       #   end
  #       # end
  # 
  #       # Jobs
  #       positions = person["positions"]["all"]
  #       if positions
  #         positions.each do |pos|
  #           start_date = DateTime.new(pos["start_date"]["year"].to_i, pos["start_date"]["month"].to_i) rescue DateTime.new(0)
  #           end_date = DateTime.new(pos["end_date"]["year"].to_i, pos["end_date"]["month"].to_i) rescue DateTime.new(0)
  #           
  #           p = Job.new(:start_date => start_date, :end_date => end_date, :position => pos["title"], :text => pos["summary"])
  #           p.minion_id = minion.id
  #           
  #           # Assign to company
  #           existing = Company.find_by_name(pos["company"]["name"])
  #           if existing
  #             p.company_id = existing.id
  #           else
  #             new_company = Company.new(:name => pos["company"]["name"])
  #             new_company.save
  #             p.company_id = new_company.id
  #           end        
  # 
  #           p.save                    
  #         end
  #       end
  #     end
  #   end
  # end
end