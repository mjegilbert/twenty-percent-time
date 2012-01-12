require 'watir-webdriver'

COMPANIES = [
  "Google Product",
  "Google HR",
  "Google People",
  "Google Business Development",
  "Google Marketing",
  "Google Research",
  "Google Finance",
  "Google Design",
  "Airbnb Engineer",
  "Airbnb Product",
  "Airbnb HR",
  "Airbnb People",
  "Airbnb Business Development",
  "Airbnb Marketing",
  "Airbnb Research",
  "Airbnb Finance",
  "Airbnb Design",
  "Microsoft Engineer",
  "Microsoft Product",
  "Microsoft HR",
  "Microsoft People",
  "Microsoft Business Development",
  "Microsoft Marketing",
  "Microsoft Research",
  "Microsoft Finance",
  "Microsoft Design",
  "Zynga Engineer",
  "Zynga Product",
  "Zynga HR",
  "Zynga People",
  "Zynga Business Development",
  "Zynga Marketing",
  "Zynga Research",
  "Zynga Finance",
  "Zynga Design",
  "LinkedIn Engineer",
  "LinkedIn Product",
  "LinkedIn HR",
  "LinkedIn People",
  "LinkedIn Business Development",
  "LinkedIn Marketing",
  "LinkedIn Research",
  "LinkedIn Finance",
  "LinkedIn Design",
  "Yahoo Engineer",
  "Yahoo Product",
  "Yahoo HR",
  "Yahoo People",
  "Yahoo Business Development",
  "Yahoo Marketing",
  "Yahoo Research",
  "Yahoo Finance",
  "Yahoo Design",
  "Palantir Engineer",
  "Palantir Product",
  "Palantir HR",
  "Palantir People",
  "Palantir Business Development",
  "Palantir Marketing",
  "Palantir Research",
  "Palantir Finance",
  "Palantir Design",
  "Apple Engineer",
  "Apple Product",
  "Apple HR",
  "Apple People",
  "Apple Business Development",
  "Apple Marketing",
  "Apple Research",
  "Apple Finance",
  "Apple Design",
  "Adobe Engineer",
  "Adobe Product",
  "Adobe HR",
  "Adobe People",
  "Adobe Business Development",
  "Adobe Marketing",
  "Adobe Research",
  "Adobe Finance",
  "Adobe Design",
  "Intuit Engineer",
  "Intuit Product",
  "Intuit HR",
  "Intuit People",
  "Intuit Business Development",
  "Intuit Marketing",
  "Intuit Research",
  "Intuit Finance",
  "Intuit Design",
  "Ebay Engineer",
  "Ebay Product",
  "Ebay HR",
  "Ebay People",
  "Ebay Business Development",
  "Ebay Marketing",
  "Ebay Research",
  "Ebay Finance",
  "Ebay Design",
  "Paypal Engineer",
  "Paypal Product",
  "Paypal HR",
  "Paypal People",
  "Paypal Business Development",
  "Paypal Marketing",
  "Paypal Research",
  "Paypal Finance",
  "Paypal Design",
  "Facebook Engineer",
  "Facebook Product",
  "Facebook HR",
  "Facebook People",
  "Facebook Business Development",
  "Facebook Marketing",
  "Facebook Research",
  "Facebook Finance",
  "Facebook Design",
  "Amazon Engineer",
  "Amazon Product",
  "Amazon HR",
  "Amazon People",
  "Amazon Business Development",
  "Amazon Marketing",
  "Amazon Research",
  "Amazon Finance",
  "Amazon Design",
  "Netflix Engineer",
  "Netflix Product",
  "Netflix HR",
  "Netflix People",
  "Netflix Business Development",
  "Netflix Marketing",
  "Netflix Research",
  "Netflix Finance",
  "Netflix Design",
  "Salesforce Engineer",
  "Salesforce Product",
  "Salesforce HR",
  "Salesforce People",
  "Salesforce Business Development",
  "Salesforce Marketing",
  "Salesforce Research",
  "Salesforce Finance",
  "Salesforce Design",
  "Twitter Engineer",
  "Twitter Product",
  "Twitter HR",
  "Twitter People",
  "Twitter Business Development",
  "Twitter Marketing",
  "Twitter Research",
  "Twitter Finance",
  "Twitter Design",
  "Yelp Engineer",
  "Yelp Product",
  "Yelp HR",
  "Yelp People",
  "Yelp Business Development",
  "Yelp Marketing",
  "Yelp Research",
  "Yelp Finance",
  "Yelp Design",
  "Quora Engineer",
  "Quora Product",
  "Quora HR",
  "Quora People",
  "Quora Business Development",
  "Quora Marketing",
  "Quora Research",
  "Quora Finance",
  "Quora Design",
  "Ning Engineer",
  "Ning Product",
  "Ning HR",
  "Ning People",
  "Ning Business Development",
  "Ning Marketing",
  "Ning Research",
  "Ning Finance",
  "Ning Design",
  "AOL Engineer",
  "AOL Product",
  "AOL HR",
  "AOL People",
  "AOL Business Development",
  "AOL Marketing",
  "AOL Research",
  "AOL Finance",
  "AOL Design",
  "Square Engineer",
  "Square Product",
  "Square HR",
  "Square People",
  "Square Business Development",
  "Square Marketing",
  "Square Research",
  "Square Finance",
  "Square Design",
  "HP", "Apple", "Intel", "Cisco Systems", "Oracle Corp", "Google", "Applied", "SYNNEX Corp.", "eBay", "Gilead Science", "Sanmina-SCI Co", "Advanced Micro", "Yahoo", "Franklin", "Symantec Corp", "Agilent", "Con-Way", "Sandisk Corp", "NetApp", "Juniper Networ", "Adobe Systems", "Intuit", "Nvidia Corp", "Robert Half", "VMware", "LSI", "Kla-Tencor Cor", "Maxim", "Xilinx", "NetFlix", "Brocade", "Contango Oil G", "Altera Corp", "Granite", "Atmel Corp", "JDS Uniphase", "Fairchild", "Linear", "Synopsys", "Intuitive", "Novellus Syste", "Trimble", "Equinix", "Spansion Inc.", "VeriFone Syste", "Cadence Design", "NETGEAR", "Finisar Corp", "Cypress", "Omnivision", "Super Micro", "Intersil Corp", "TIBCO Software", "Plantronics", "Quantum Corp.", "Coherent", "Informatica Co", "PMC - Sierra", "West Marine", "Integrated", "Synaptics", "Trident", "Rovi Corporati", "EFI", "Silicon Graphi", "Blue Coat", "California", "Oclaro", "Infinera", "Harmonic", "Essex Property", "Align Technolo", "NetLogic", "QuinStreet", "Ariba", "IXYS Corp", "Extreme Networ", "FORTINET", "Rambus", "Aruba Networks", "Affymetrix", "Shutterfly", "Tessera", "Power", "Micrel", "Sigma Designs", "Integrated", "Landec Corp", "Exponent", "Applied Micro", "DSP Group", "Omnicell", "Tivo", "Monolithic", "Natus Medical", "SJW Corp.", "Cepheid", "Symmetricom", "Cavium Network", "Accuray", "Intevac", "SuccessFactors", "TeleNav", "NetSuite", "Ikanos", "Silicon Image", "Nanometrics", "Genomic Health", "Oplink", "Jazz", "ShoreTel", "Openwave Syste", "Pericom", "eHealth", "iPass", "Volterra", "Exar Corp", "Conceptus", "Ultratech", "Abaxis", "Mattson", "Magma Design", "Dialogic", "Tesla Motors", "Protalix", "Saba Software", "Questcor", "Affymax", "FINANCIAL", "Echelon Corp", "Coast", "Mission West", "GSI Technology", "AXT", "Geeknet", "Advanced", "Supertex", "MIPS", "Meru Networks"]

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
  count = 0
  while count < 200
    if browser.li(:id,"vcard-0")
      (0..9).each do |i|
        if browser.li(:id,"vcard-#{i}").html =~ /<a href="(\/profile\/view[^"]+)"/
          browser.goto "www.linkedin.com"+$1
          sleep(1)
          browser.back
          sleep(2)
          count += 1 
        end
      end
    end
    sleep(1)
    browser.link(:class,"paginator-next").click rescue break
    sleep(2)
  end
  sleep(rand()*900)
end

def main
  browser = sign_in
  puts "Install extension and press enter"
  gets
  COMPANIES.shuffle!.each do |company|
    search_company(company,browser)
    f = File.open("completed_queries.txt", "a")
    f.puts company
    f.close
    grab_contacts(browser)
  end
  browser.close
end

main