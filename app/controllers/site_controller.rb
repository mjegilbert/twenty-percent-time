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
    
    user = User.new(:atoken => atoken, :asecret => asecret)
    user.save
    
    session[:atoken] = atoken
    session[:asecret] = asecret
    
    @name = "Space Traveler"
  end
  
  def show
    client = LinkedIn::Client.new('4wkfc3lzk92h', '7C2BKYvq04X3K2hB')
    client.authorize_from_access(session[:atoken], session[:asecret])
    
    # Queue up a worker to retrieve user's connections
    worker = ConnectionWorker.new
    worker.atoken = session[:atoken]
    worker.asecret = session[:asecret]
    worker.queue
    
    # Calculate analysis
    # ...
  end
end