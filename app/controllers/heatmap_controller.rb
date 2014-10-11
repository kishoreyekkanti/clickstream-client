require 'couchbase'
class HeatmapController < ApplicationController

  def index
    client = Couchbase.connect(:bucket => "clickStream",
                               :hostname => "localhost")
    email = session[:user_email]
    @pages = client.get("#{email}_pages")
    @resolutions = [320, 768, 1024, 1280, 1366, 1440, 1600, 1680, 1920];
    client.disconnect
  end

  def imagesource
    client = Couchbase.connect(:bucket => "clickStream",
                               :hostname => "localhost")
    image_paths = client.get(params[:key])
    respond_to do |format|
      format.json { render json: {"source" => "/images/"+image_paths['relativePath']} };
    end
    client.disconnect
  end

  def points
    client = Couchbase.connect(:bucket => "clickStream", :hostname => "localhost")
    email = session[:user_email]
    pages = client.get("#{email}_pages")
    location_name = pages[params[:location_url]]
    key = "#{email}_#{location_name}_#{params[:user_action]}_#{params[:resolution]}_20141012"
    points = client.get(key, :format => :plain)
    respond_to do |format|
      format.json { render json: {"points" => points} };
    end
    client.disconnect
  end
end