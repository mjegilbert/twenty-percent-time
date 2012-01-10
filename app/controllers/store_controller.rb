class StoreController < ApplicationController
  skip_before_filter :verify_autenticity_token

  def create
    params = {"first_name"=>"Hritika", "last_name"=>"Sharma", 
      "education"=>{
        "0"=>{"school"=>"Harvard Business School", 
        "start"=>"2011-01-01", "end"=>"2013-12-31", "degree"=>"MBA", "major"=>"", "text"=>"\n    \n"}, 
        "1"=>{"school"=>"Indian Institute of Management, Ahmedabad", "start"=>"2005-01-01", "end"=>"2007-12-31", "degree"=>"MBA", "major"=>"", 
          "text"=>"\n    \n"}, 
        "2"=>{"school"=>"Indian Institute of Technology, Delhi", "start"=>"2001-01-01", "end"=>"2005-12-31", "degree"=>"B.Tech", 
          "major"=>"Electrical Engineering", "text"=>"\n    \n"}, 
        "3"=>{"school"=>"Delhi Public School - R. K. Puram", "start"=>"1995-01-01", "end"=>"2001-12-31", "degree"=>"", "major"=>"", "text"=>"\n    \n"}}, 
      "experience"=>{
        "0"=>{"position"=>"Associate Principal", "start"=>"2009-02-01", "end"=>"2011-06-01", "company"=>"McKinsey &amp; Company", 
          "text"=>"\n    Working as management consultant at Business Technology Office, with focus on Telecommunications and Banking industries.<br>\n<br>\n  
          Application Management<br>\n  IT Architecture<br>\n?? IT Strategy<br>\n  IT Governance &amp; Organization<br>\n  Lean IT\n"}, 
        "1"=>{"position"=>"Financial Advisor", "start"=>"2008-07-01", "end"=>"2009-12-01", "company"=>"Morgan Stanley", "text"=>""}, 
        "2"=>{"position"=>"Associate, Global Sales Strategy &amp; Operations", "start"=>"2007-06-01", "end"=>"2008-06-01", "company"=>"Google", 
          "text"=>"\n    Led and managed 7 teams across 4 countries (60+ individuals) to deliver staffing solutions across the EMEA marketplace including; 
          sourcing, staffing, and graduate recruitment<br>\n<br>\nCreated, organized and led the global Social Media in Recruiting task force establishing a
           global message and presence on multiple platforms (Facebook, Twitter, YouTube, etc)<br>\n<br>\nFocused on continual improvements in process flow, 
           idea generation, productivity gains and results leading to achieving hiring targets quarter after quarter<br>\n<br>\nEliminated agency use (saving 
           1MM USD), restructured teams and built a highly capable, cross-functional team able to work together across borders on improvement and innovation 
           <br>\n<br>\nConducted a global audit of Google's staffing function to identify best-practices resulting in a complete re-organization and streamlining
            of the 300+ person team for improved results\n"}, 
          "3"=>{"position"=>"Volunteer", "start"=>"2007-05-01", "end"=>"2007-06-01", "company"=>"Mazdoor Kisan Shakti Sangathan (MKSS)", 
            "text"=>"\n    Grassroots organization working in rural Rajasthan (India) on issues such as Right to Information (RTI), minimum wages, employment
            guarantee and land re-distribution<br>\n<br>\n- Selected as a SPIC MACAY Scholar to intern under Smt. Aruna Roy (Ramon Magsaysay Awardee, founder 
            of MKSS)<br>\n- Worked on the implementation of the National Rural Employment Guarantee Act (N.R.E.G.A) in the villages of Rajasthan<br>\n- Visited 
            worksites, addressed worker grievances and ensured proper implementation of procedures to eliminate corruption\n"}, 
          "4"=>{"position"=>"Summer intern", "start"=>"2006-04-01", "end"=>"2006-06-01", "company"=>"The Boston Consulting Group", 
            "text"=>"\n    Part of an 8 member team which worked on a 'Business Development Excellence' effort for a large Indian construction major<br>\n- 
            Responsible for formulating the Go-to-market strategy for a key business segment of the client - Presented the recommendations directly to the client 
            chairman <br>\n- Received a pre-placement offer for a full time position\n"}, 
          "5"=>{"position"=>"Summer intern", "start"=>"2004-05-01", "end"=>"2004-07-01", "company"=>"Stanford University", "text"=>"\n    - Worked with a 
            team of researchers of 7 different nationalities in the field of mathematical signal processing<br>\n<br>\n- Developed a novel technique for 
            separation of muscle signals to help predict the strength of postural muscles in elderly people\n"}}, 
        "search"=>"?id=95435386&authType=name&authToken=asta&goback=%2Enmp_*1_*1_*1_*1_*1_*1&trk=NUS_DIG_CONN-connctr", "controller"=>"store", "action"=>"create"}
    educations = params["education"]
    experiences = params["experience"]
    search = params["search"]
    search =~ /id=([^&]+)/
    id = $1
    minion = Minion.find_by_uuid(id)
    if minion 
      minion = Minion.create(:uuid => id, :first_name => params["first_name"], :last_name => params["last_name"])
      educations.each do |num, ed|
        ed_school = sanitize_linkedin ed["school"]
        ed_start = sanitize_linkedin ed["start"]
        ed_end = sanitize_linkedin ed["end"]
        ed_degree = sanitize_linkedin ed["degree"]
        ed_major = sanitize_linkedin ed["major"]
        ed_text = sanitize_linkedin ed["text"]
        if !ed_school.empty? && (ed_start)
          school = School.find_by_name(ed_school) || School.create("name" => ed_school)
          ed_session = EdSession.create(:minion => minion, :school => school, 
            :start_date => ed_start, :end_date => ed_end, :degree => ed_degree, 
            :major => ed_major, :text => ed_text)
        end
      end
      experiences.each do |num,exp|
        exp_company = sanitize_linkedin exp["company"]
        exp_start = sanitize_linkedin exp["start"]
        exp_end = sanitize_linkedin exp["end"]
        exp_position = sanitize_linkedin exp["position"]
        exp_text = sanitize_linkedin exp["text"]
        if !exp_company.empty? && (exp_start)
          company = Company.find_by_name(exp_company) || Company.create("name" => exp_company)
          ed_session = Job.create(:minion => minion, :company => company, 
            :start_date => exp_start, :end_date => exp_end, :position => exp_position, 
            :text => exp_text)
        end
      end
    end 
      
    respond_to do |format|
      format.html { render :text => "html" }
      format.js { render :text => "js" }
    end
  end
  
  private 
  def sanitize_linkedin(string)
    string.gsub(/[^\w'\.\s]/, "").downcase
  end
end
