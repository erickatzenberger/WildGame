class SteakCutsController < ApplicationController
  def create
    @order = Order.find params[:order_id]
    @steak_cut = SteakCut.new params[:steak_cut]

    if @steak_cut.valid?
      @order.steak_cuts << @steak_cut
      @order.save
      render json: {steakCutsForm: render_to_string(partial: 'orders/steak_cuts') }
    else
      render json: {errors: @steak_cut.errors.full_messages.join("\n")}
    end
  end
end
