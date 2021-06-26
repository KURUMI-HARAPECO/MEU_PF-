class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_cart_items, only: [:new, :confirm, :create, :error]

  def new
    @orders = Order.all
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
  end

  def error
  end

  def create
    @order = current_customer.orders.new(order_params)
    if @order.save
      current_customer.cart_items.destroy_all
      redirect_to complete_path
    else
      render :new
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.includes(:order_details, :items).page(params[:page]).reverse_order
  end

  def show
    @order = current_customer.orders.find(params[:id])
    # @order_details = @order.order_details.includes(:item)
  end

  private

  def order_params
    params.require(:order).permit(:minute, :time, :name, :payment_method)
  end

  def ensure_cart_items
    @cart_items = current_customer.cart_items.includes(:item)
    redirect_to items_path unless @cart_items.first
  end
end
