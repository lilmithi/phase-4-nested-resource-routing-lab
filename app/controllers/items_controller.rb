class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found


  def index
    if params[:user_id]
      user=User.find(params[:user_id])
      items=user.items
    else
    items = Item.all
    end
    render json: items, include: :user
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_response_not_found
    render json: {error: "User not found"}, status: :not_found
  end
end
