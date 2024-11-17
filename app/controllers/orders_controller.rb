class OrdersController < ApplicationController
  def index
    @open_orders = Order.open_orders
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:state)
  end
end
