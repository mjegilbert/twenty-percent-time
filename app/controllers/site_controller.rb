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
    @the_shit = client.connections(:fields =>["id", "first-name", "last-name", "phone-numbers", "main-address","positions", "educations", "honors", "associations", "interests", "picture-url"]) ["all"]
  end
end