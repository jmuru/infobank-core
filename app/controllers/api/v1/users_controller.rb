class Api::V1::UsersController < Api::V1::BaseController
  def info
    user = User.find(params[:id])
    stores = []
    user.store_auth.each_key {|k| stores.push(k)}
    response_object = {
      "stores" => stores
    }
    render json: response_object
  end
end
