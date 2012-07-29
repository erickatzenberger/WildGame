class TrimmingsController < ApplicationController
  def create
    @order = Order.find params[:order_id]
    @trimming = Trimming.new
  end
end