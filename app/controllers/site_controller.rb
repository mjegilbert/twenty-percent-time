class SiteController < ApplicationController
  def index
  end
  
  def logout
    redirect_to :action => "index"
  end
  
  def authorize_linkedin
    callback = "http://#{request.host_with_port}/site/donk"
    client = LinkedIn::Client.new('4wkfc3lzk92h', '7C2BKYvq04X3K2hB')
    request_token = client.request_token(:oauth_callback => callback) 
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    
    redirect_to client.request_token.authorize_url
  end

  def donk
    client = LinkedIn::Client.new('4wkfc3lzk92h', '7C2BKYvq04X3K2hB')
    pin = params[:oauth_verifier]
    atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
    
    session[:atoken] = atoken
    session[:asecret] = asecret
    
    @name = "Space Traveler"
  end
  
  
  def show
    client = LinkedIn::Client.new('4wkfc3lzk92h', '7C2BKYvq04X3K2hB')
    client.authorize_from_access(session[:atoken], session[:asecret])
    @the_shit = client.connections(:fields =>["id", "first-name", "last-name", "phone-numbers", "main-address","positions", "educations", "honors", "associations", "interests", "picture-url"])["all"]

    @the_shit.each do |person|
      begin
        # General
        uuid = person["id"]
        
        
        minion = Minion.new(:first_name => person["first_name"],
                            :last_name => person["last_name"],
                            :uuid => uuid)
        minion.save
        
        # # School  
        # educations = person["educations"]["all"]
        # if educations
        #   educations.each do |ed|
        #     #e = EdSession.new(:start_date => ed["start_date"]["year"], :end_date => ed["end_date"]["year"])
        #     e = EdSession.new
        #     e.minion_id = minion.id
        # 
        #     existing = School.find_by_name(ed["school_name"])
        #     if existing
        #       e.school_id = existing.id
        #     else
        #       new_school = School.new(:name => ed["school_name"])
        #       new_school.save
        #       e.school_id = new_school.id
        #     end
        #       
        #     e.save
        #   end
        # end
    
        # Jobs
        positions = person["positions"]["all"]
        if positions
          positions.each do |pos|
            start_date = DateTime.new(pos["start_date"]["year"].to_i, pos["start_date"]["month"].to_i) rescue DateTime.new(0)
            end_date = DateTime.new(pos["end_date"]["year"].to_i, pos["end_date"]["month"].to_i) rescue DateTime.new(0)
                        
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
      rescue
        puts "error with " + person.inspect
      end
    end
  end
end