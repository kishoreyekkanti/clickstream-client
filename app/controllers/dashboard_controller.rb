require 'couchbase'
class DashboardController < ApplicationController
  before_filter :authenticate

  def index
    client = Couchbase.connect(:bucket => COUCH_CONFIG['bucket'], :hostname => COUCH_CONFIG['hostname'])
    @email = session[:user_email]
    @pages = client.get("#{@email}_pages")
    client.disconnect
  end

  private
  def authenticate
    unless session[:user_email]
      redirect_to users_login_path
    end
  end
end