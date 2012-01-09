class StoreController < ApplicationController
  skip_before_filter :verify_autenticity_token

  def create
    puts params
    respond_to do |format|
      format.html { render :text => "html" }
      format.js { render :text => "js" }
    end
  end
end
