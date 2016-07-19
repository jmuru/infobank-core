class ManageController < ApplicationController
  before_action :authenticate_user!
  def index
    attach_variables
  end

  private

  def attach_variables
    gon.dropbox_url = api_v1_stores_authorize_url(id: "dropbox", user_id: current_user.id, subdomain: "api")
    gon.folder_url = api_v1_bank_folders_url
    gon.download_url = api_v1_bank_assets_url
    gon.user_url = api_v1_user_info_url(id: current_user.id)
    gon.home_folder = current_user.core_folders["Home"].to_s
  end
end
