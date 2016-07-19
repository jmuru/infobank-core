class Api::V1::Bank::FoldersController < Api::V1::BaseController
  def items
    folder = Folder.find(params[:id])
    entries = []
    folder.folders.each { |f| entries.push(f.metadata_short)}
    folder.assets.each {|a| entries.push(a.metadata_short)}
    #TODO Configure additional options
    offset = 0
    limit = 0
    order = []
    response_object = {
      "modified" => folder.modified,
      "update_in_progress" => folder.user.update_in_progress,
      "total_count" => entries.count,
      "entries" => entries,
      "parents" => folder.full_tree,
      "offset" => offset,
      "limit" => limit,
      "order" => order
    }
    if folder.modified
      folder.modified = false
      folder.save
    end
    render json: response_object
  end
end
