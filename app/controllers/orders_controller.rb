class OrdersController < ApplicationController
  def index
    @open_orders = Order.open_orders
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params) ? respond_success(self.__method__.to_s) : respond_failure(self.__method__.to_s)
  end

  private

  def order_params
    params.require(:order).permit(:state)
  end

  def respond_success(method_name)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to orders_path, notice: "Order #{method_name}ed successfully" }
    end
  end

  def respond_failure(method_name)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@order, partial: "orders/order", locals: { order: @order }) }
      format.html { render :index, notice: "Order couldn't be #{method_name}ed", status: :unprocessable_entity }
    end
  end
end
