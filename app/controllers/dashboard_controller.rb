require 'couchbase'
class DashboardController < ApplicationController
  before_filter :authenticate

  def index
    client = Couchbase.connect(:bucket => COUCH_CONFIG['bucket'], :hostname => COUCH_CONFIG['hostname'])
    @email = session[:user_email]
    @pages = client.get("#{@email}_pages")
    @resolutions = [1920, 1680, 1600, 1440, 1360, 1280, 1024,  800, 768, 320]
    client.disconnect
  end

  private
  def authenticate
    unless session[:user_email]
      redirect_to users_login_path
    end
  end
end