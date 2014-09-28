require 'couchbase'
class DashboardController < ApplicationController
  before_filter :authenticate

  def index
    client = Couchbase.connect(:bucket => COUCH_CONFIG['bucket'], :hostname => COUCH_CONFIG['hostname'])
    @pages = client.get("stayzilla_pages")
    @resolutions = [320, 768, 1024, 1280, 1366, 1440, 1600, 1680, 1920];
    client.disconnect
  end

  private
  def authenticate
    unless session[:user_email]
      redirect_to users_login_path
    end
  end
end