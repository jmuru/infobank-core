class RecordDropbox
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user

  field :files, type: Hash, default: Hash.new
  field :folders, type: Hash, default: Hash.new
  field :root_hash, type: String

  def file_modified(record, time_string)
    if self.files[record].nil?
      return :new
    else
      if DateTime.strptime(self.files[record], "%a, %d %b %Y %H:%M:%S %z") < DateTime.strptime(time_string, "%a, %d %b %Y %H:%M:%S %z")
        return :modified
      else
        return :unmodified
      end
    end
  end
end
