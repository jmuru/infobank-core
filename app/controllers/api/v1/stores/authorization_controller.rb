class Api::V1::Stores::AuthorizationController < ApplicationController
  require 'dropbox_sdk'

  def authorize
    dbsession = DropboxSession.new(DROPBOX_APP_KEY, DROPBOX_APP_KEY_SECRET)
    #serialize and save this DropboxSession
    session[:dropbox_session] = dbsession.serialize
    #pass to get_authorize_url a callback url that will return the user here
    redirect_to dbsession.get_authorize_url url_for(action: 'callback', id: "dropbox", user_id: params[:user_id])
  end

  def callback
    dbsession = DropboxSession.deserialize(session[:dropbox_session])
    dbsession.get_access_token
    session[:dropbox_session] = dbsession.serialize
    current_user = User.find(params[:user_id])
    current_user.store_auth["dropbox"] = session[:dropbox_session]
    current_user.record_dropbox = RecordDropbox.create if current_user.record_dropbox.nil?
    current_user.save
    session.delete :dropbox_session
    DropboxJob.perform_now(params[:user_id])
    flash[:success] = "You have successfully authorized with dropbox."
    redirect_to root_url(subdomain: false)
  end
end
