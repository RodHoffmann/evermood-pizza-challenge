class OrdersController < ApplicationController
  def index
    @open_orders_with_details = Order.open_orders_with_details
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
      format.turbo_stream do
        flash[:notice] = "Order #{method_name}d successfully"
        render turbo_stream: [
          turbo_stream_flash,
          turbo_stream.remove("order-#{params[:id]}")
        ]
      end
      format.html { redirect_to orders_path, notice: "Order #{method_name}d successfully" }
    end
  end

  def respond_failure(method_name)
    respond_to do |format|
      format.turbo_stream do
        flash[:alert] = "Order couldn't be #{method_name}d"
        render turbo_stream: [turbo_stream_flash,
                              turbo_stream.replace("order-#{params[:id]}",
                                                   partial: 'orders/order_card', locals: { order: @order })]
      end
      format.html { render :index, notice: "Order couldn't be #{method_name}d", status: :unprocessable_entity }
    end
  end

  def turbo_stream_flash
    turbo_stream.update('flash', partial: 'shared/flash')
  end
end
