class Asset
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :folder

  field :name, type: String, default: ""
  field :unique_id, type: String
  field :url, type: String
  field :store, type: String
  field :size, type: String
  field :bytes, type: Integer
  field :mime_type, type: String
  field :icon, type: String

  def metadata_short
    return {
      "type" => "file",
      "id" => self.id.to_s,
      "name" => self.name
    }
  end

  def mark_parent
    self.folder.modified = true
    self.folder.save
  end

  def set_dropbox_data(data)
    self.name = data["path"].split('/').last
    self.unique_id = data["rev"]
    self.url = data["path"]
    self.store = "dropbox"
    self.size = data["size"]
    self.bytes = data["bytes"]
    self.mime_type = data["mime_type"]
  end

  def init_ownership(user)
    self.user = user
    type, subtype = self.mime_type.split('/')
    if type == "image"
      self.folder = Folder.find(user.core_folders["Pictures"])
    elsif type == "video"
      self.folder = Folder.find(user.core_folders["Videos"])
    elsif type == "text"
      self.folder = Folder.find(user.core_folders["Text"])
    elsif ["pdf","msword","book","mspowerpoint","powerpoint","rtf","wordperfect","vnd.openxmlformats-officedocument.wordprocessingml.document"].include? subtype
      self.folder = Folder.find(user.core_folders["Documents"])
    else
      self.folder = Folder.find(user.core_folders["Data"])
    end
  end
end
