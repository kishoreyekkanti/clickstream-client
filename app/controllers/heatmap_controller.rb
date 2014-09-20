require 'couchbase'
class HeatmapController < ApplicationController

  def index
    client = Couchbase.connect(:bucket => "clickStream",
                               :hostname => "localhost")
    @pages = client.get("stayzilla_pages")
    @resolutions = [320, 768, 1024, 1280, 1366 , 1440, 1600 , 1680, 1920];
    client.disconnect
  end

  def imagesource
    client = Couchbase.connect(:bucket => "clickStream",
                               :hostname => "localhost")
    image_paths = client.get(params[:key])
    puts image_paths;
    respond_to do |format|
      format.json {render json:{"source"=>"/images/"+image_paths['relativePath']}};
    end
    client.disconnect
  end
end