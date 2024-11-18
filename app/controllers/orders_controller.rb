class OrdersController < ApplicationController
  def index
    @open_orders = Order.open_orders
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to orders_path, notice: 'Order updated successfully' }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@order, partial: "orders/order", locals: { order: @order }) }
        format.html { render :index, notice: "Order couldn't be updated", status: :unprocessable_entity }
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:state)
  end
end
