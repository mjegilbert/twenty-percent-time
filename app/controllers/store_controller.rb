class StoreController < ApplicationController
  skip_before_filter :verify_autenticity_token

  def create
    params = {"education"=>{"0"=>{"school"=>"University of California, Santa Cruz", "start"=>"", "end"=>"", "degree"=>"", "major"=>"", "text"=>"\n    \n"}}, "experience"=>{"0"=>{"position"=>"Senior Systems Administrator", "start"=>"2006-07-01", "end"=>"", "company"=>"Ingres Corporation", "text"=>"\n    Senior systems administrator with responsibilities that include infrastructure architecture/support for the main web-site and customer facing ticketing system using Red Hat linux, SAN/NAS administrator/architect with deployment experience and support of EMC Clariion/Celerra/HP/DELL solutions,  complete setup and and support of ESX VMware infrastructure including virtucal center and 200+ VMs, and primary support for engineering systems in the US (Solaris, AIX, HPUX, etc.)\n"}, "1"=>{"position"=>"Unix Administrator", "start"=>"2004-08-01", "end"=>"2006-07-01", "company"=>"Marvell Tech", "text"=>"\n    Unix administrator supporting infrastructure services such as backup and recovery services (Veritas Netbackup), Linux grid computing environment with over 700 servers, Sun Solaris servers and workstations (Solaris 7,8,9, and some 10), and some EMC/Netapp high end storage support.\n"}, "2"=>{"position"=>"Senior Unix Administrator", "start"=>"2001-04-01", "end"=>"2004-08-01", "company"=>"Portal Software Inc.", "text"=>"\n    Comprehensive support of key IT services such as DNS (BIND), sendmail, backup and recovery, ERP Oracle financials running on EMC symmetrix, NIS/NFS.\n"}}, "search"=>"?id=6066339&goback=%2Enpv_64614345_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1%2Enpv_97569144_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1%2Enpv_44404388_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1_*1"}
    educations = params["education"]
    experiences = params["experience"]
    search = params["search"]
    search =~ /id=(.*)&/
    id = $1
    minion = Minion.find_by_uuid(id)
    if !minion 
      minion = Minion.create
      minion.uuid = id
      
      educations.each do |ed|
        school = School.find_by_name(ed["school"]) || School.create("name" => ed["school"])
        ed_session = EdSession.create
      end
    end 
    # education sections 
      
    respond_to do |format|
      format.html { render :text => "html" }
      format.js { render :text => "js" }
    end
  end
end
