class StoreController < ApplicationController
  skip_before_filter :verify_autenticity_token

  def create
    puts "receiving post"
    educations = params["education"] || []
    experiences = params["experience"] || []
    search = params["search"]
    search =~ /id=([^&]+)/
    id = $1
    minion = Minion.find_by_uuid(id)
    if !minion 
      puts "created new minion"
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
    else
      puts "minion found"
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
