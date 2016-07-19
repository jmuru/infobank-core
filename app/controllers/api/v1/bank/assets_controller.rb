class Api::V1::Bank::AssetsController < Api::V1::BaseController
  require 'dropbox_sdk'

  def content
    file = Asset.find(params[:id])

    #TODO This should really be handled elsewhere
    if file.store == "dropbox"
      user = file.user
      dropbox = user.store_auth["dropbox"]
      dbsession = DropboxSession.deserialize(dropbox)
      client = DropboxClient.new(dbsession, DROPBOX_APP_MODE)
      file_share = client.shares(file.url)
      redirect_to file_share["url"]
    end
  end
end
