class OrdersController < ApplicationController
  def index
    @open_orders = Order.open_orders
  end

  def update
    order = Order.find(params[:id])
    if order.update(order_params)
      redirect_to orders_path, notice: 'Order updated successfully'
    else
      render :index, notice: "Order couldn't be updated", status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:state)
  end
end
