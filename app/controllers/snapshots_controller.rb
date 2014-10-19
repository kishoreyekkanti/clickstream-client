class SnapshotsController < ApplicationController

  def create
    email = authenticated
    if email
      snapshot_uploader = SnapshotUploader.new
      snapshot_uploader.store!(params[:snapshot_image])
      create_snapshot(params, snapshot_uploader.store_dir, snapshot_uploader.filename, snapshot_uploader.realname)
      redirect_to users_profile_path
    else
      redirect_to users_login_path
    end
  end

  private
  def create_snapshot(params, dir, filename, original_filename)
    relative_path = dir+filename
    absolute_array = dir.split("/")
    absolute_path = absolute_array[absolute_array.length - 1] + filename
    id = session[:user_email]+"_"+params[:url]+"_"+params[:resolution]
    snapshot_from_db = Snapshot.find_by_id(id)
    if snapshot_from_db
      save_snapshot(snapshot_from_db, id, absolute_path, relative_path, original_filename)
    else
      save_snapshot(Snapshot.new, id, absolute_path, relative_path, original_filename)
    end
  end

  def authenticated
    session[:user_email]
  end

  def save_snapshot(snapshot, id, absolute_path, relative_path, original_filename)
    snapshot.id = id
    snapshot.type = "image_paths"
    snapshot.absolutePath = absolute_path
    snapshot.relativePath = relative_path
    snapshot.originalFileName = original_filename
    snapshot.save()

  end
end