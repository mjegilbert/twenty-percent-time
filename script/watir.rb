require 'watir-webdriver'

COMPANIES = ["HP", "Apple", "Intel", "Cisco Systems", "Oracle Corp", "Google", "Applied", "SYNNEX Corp.", "eBay", "Gilead Science", "Sanmina-SCI Co", "Advanced Micro", "Yahoo", "Franklin", "Symantec Corp", "Agilent", "Con-Way", "Sandisk Corp", "NetApp", "Juniper Networ", "Adobe Systems", "Intuit", "Nvidia Corp", "Robert Half", "VMware", "LSI", "Kla-Tencor Cor", "Maxim", "Xilinx", "NetFlix", "Brocade", "Contango Oil G", "Altera Corp", "Granite", "Atmel Corp", "JDS Uniphase", "Fairchild", "Linear", "Synopsys", "Intuitive", "Novellus Syste", "Trimble", "Equinix", "Spansion Inc.", "VeriFone Syste", "Cadence Design", "NETGEAR", "Finisar Corp", "Cypress", "Omnivision", "Super Micro", "Intersil Corp", "TIBCO Software", "Plantronics", "Quantum Corp.", "Coherent", "Informatica Co", "PMC - Sierra", "West Marine", "Integrated", "Synaptics", "Trident", "Rovi Corporati", "EFI", "Silicon Graphi", "Blue Coat", "California", "Oclaro", "Infinera", "Harmonic", "Essex Property", "Align Technolo", "NetLogic", "QuinStreet", "Ariba", "IXYS Corp", "Extreme Networ", "FORTINET", "Rambus", "Aruba Networks", "Affymetrix", "Shutterfly", "Tessera", "Power", "Micrel", "Sigma Designs", "Integrated", "Landec Corp", "Exponent", "Applied Micro", "DSP Group", "Omnicell", "Tivo", "Monolithic", "Natus Medical", "SJW Corp.", "Cepheid", "Symmetricom", "Cavium Network", "Accuray", "Intevac", "SuccessFactors", "TeleNav", "NetSuite", "Ikanos", "Silicon Image", "Nanometrics", "Genomic Health", "Oplink", "Jazz", "ShoreTel", "Openwave Syste", "Pericom", "eHealth", "iPass", "Volterra", "Exar Corp", "Conceptus", "Ultratech", "Abaxis", "Mattson", "Magma Design", "Dialogic", "Tesla Motors", "Protalix", "Saba Software", "Questcor", "Affymax", "FINANCIAL", "Echelon Corp", "Coast", "Mission West", "GSI Technology", "AXT", "Geeknet", "Advanced", "Supertex", "MIPS", "Meru Networks"]

def sign_in
  browser = Watir::Browser.new :chrome
  browser.goto "http://www.linkedin.com"
  File.open("data.txt","r") do |f|
    browser.text_field(:name, "session_key").set f.gets.strip()
    browser.text_field(:name, "session_password").set f.gets.strip()
  end
  browser.button(:id, "signin").click
  browser
end

def search_company(company,browser)
  browser.text_field(:id => "main-search-box").set company
  browser.button(:name => "search").click
end

def grab_contacts(browser)
  while true
    if browser.li(:id,"vcard-0")
      (0..9).each do |i|
        if browser.li(:id,"vcard-#{i}").html =~ /<a href="(\/profile\/view[^"]+)"/
          browser.goto "www.linkedin.com"+$1
          sleep(1)
          browser.back
          sleep(2)
        end
      end
    end
    sleep(1)
    browser.link(:class,"paginator-next").click rescue break
    sleep(2)
  end
end

def main
  browser = sign_in
  puts "Install extension and press enter"
  gets
  COMPANIES.each do |company|
    search_company(company,browser)
    grab_contacts(browser)
  end
  browser.close
end

main