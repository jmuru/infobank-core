class DropboxJob < ActiveJob::Base
  queue_as :default
  require 'dropbox_sdk'

  def perform(*args)
    @user = User.find(args[0])
    @records = @user.record_dropbox
    dropbox = @user.store_auth["dropbox"]
    dbsession = DropboxSession.deserialize(dropbox)
    @client = DropboxClient.new(dbsession, DROPBOX_APP_MODE)

    @user.update_in_progress = true
    @user.save
    update('/')
    @records.save
    @user.update_in_progress = false
    @user.save
  end

  private

  def update(path, rev=nil)
    begin
      # if rev.nil?
      #   metadata = @client.metadata(path,25000,true,@records.root_hash)
      # else
      #   metadata = @client.metadata(path,25000,true,@records.folders[rev])
      # end
      #Above will throw an exception if folder hasn't been modified

      metadata = @client.metadata(path)
      if metadata["rev"].nil?
        @records.root_hash = metadata["hash"]
      else
        @records.folders[metadata["rev"]] = metadata["hash"]
      end

      contents = metadata["contents"]
      contents.each do |item|
        if item["is_dir"]
          update(item["path"],item["rev"])
        else
          case @records.file_modified(item["rev"],item["modified"])
          when :new
            file = Asset.new
            file.set_dropbox_data(item)
            file.init_ownership(@user)
            if file.save
              @records.files[item["rev"]] = item["modified"]
              file.mark_parent
            else
              #Handle error
            end
          when :modified
            file = Asset.where(unique_id: item["rev"], user_id: @user.id).first
            file.set_dropbox_data(item)
            if file.save
              @records.files[item["rev"]] = item["modified"]
              file.mark_parent
            else
              #Handle error
            end
          end
        end
      end
    rescue
      #DropboxNotModified
      #Too many files
    end
  end
end
