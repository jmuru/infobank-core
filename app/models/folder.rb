class Folder
  include Mongoid::Document
  include Mongoid::Timestamps
  has_many :assets
  has_many :folders
  belongs_to :user
  belongs_to :folder

  field :name, type: String, default: ""
  field :icon, type: String, default: "folder"
  field :modified, type: Boolean, default: false

  def metadata_short
    return {
      "type" => "folder",
      "id" => self.id.to_s,
      "name" => self.name
    }
  end

  #TODO Save this to the model instead of building it for every request
  def full_tree
    tree = [{name: self.name, id: self.id.to_s}]
    folder = self
    while folder.folder != nil
      folder = folder.folder
      tree.push({name: folder.name, id: folder.id.to_s})
    end
    return tree.reverse
  end
end
