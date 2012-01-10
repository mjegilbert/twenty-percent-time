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
      minion = Minion.create(:uuid => id, :first_name => params["first_name"], :last_name => params["last_name"], :wid => params["wid"])
      educations.each do |num, ed|
        next if ed["school"].empty?
        ed_school = sanitize_linkedin ed["school"]
        next if ed["start"].empty?
        ed_start = ed["start"].length == 4 ? DateTime.strptime(ed["start"],"%Y") : DateTime.strptime(ed["start"],"%Y-%m-%d")
        ed_end = ed["end"].length == 4 ? DateTime.strptime(ed["end"],"%Y") : DateTime.strptime(ed["end"],"%Y-%m-%d") rescue nil
        ed_degree = sanitize_linkedin ed["degree"]
        ed_major = sanitize_linkedin ed["major"]
        ed_text = sanitize_linkedin ed["text"]
        school = School.find_by_name(ed_school) || School.create("name" => ed_school)
        ed_session = EdSession.create(:minion => minion, :school => school, 
          :start_date => ed_start, :end_date => ed_end, :degree => ed_degree, 
          :major => ed_major, :text => ed_text)
      end
      
      experiences.each do |num,exp|
        next if exp["company"].empty?
        exp_company = sanitize_linkedin exp["company"]
        next if exp["start"].empty?
        exp_start = exp["start"].length == 4 ? DateTime.strptime(exp["start"],"%Y") : DateTime.strptime(exp["start"],"%Y-%m-%d")
        exp_end = exp["end"].length == 4 ? DateTime.strptime(exp["end"],"%Y") : DateTime.strptime(exp["end"],"%Y-%m-%d") rescue nil
        exp_position = sanitize_linkedin exp["position"]
        exp_text = sanitize_linkedin exp["text"]
        company = Company.find_by_name(exp_company) || Company.create("name" => exp_company)
        ed_session = Job.create(:minion => minion, :company => company, 
          :start_date => exp_start, :end_date => exp_end, :position => exp_position, 
          :text => exp_text)
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
    string.gsub(/<\/?[^>]+>/,"")
    string.gsub(/[^\w'\.\s]/, "").downcase
  end
end
