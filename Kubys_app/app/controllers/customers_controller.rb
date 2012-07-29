class CustomersController < ApplicationController
  def create
    if params[:order_id].present?
      @order = Order.find params[:order_id]
    else
      @order = Order.new
    end

    logger.info "How many customers before: #{@order.customers.count}"

    unless params[:dont_save_add_game] == '1'
      @customer = Customer.new params[:customer]

      @order.customers << @customer
      if @customer.valid? and @order.save
        logger.info "How many customers after: #{@order.customers.count}"
        json = {
          orderId: @order.id,
          customers: render_to_string(partial: 'orders/customers', locals: { customers: @order.customers }),
          customersQuantity: @order.customers.count,
          url: edit_order_path(@order),
        }
        if params[:add_next_customer] == '1'
          json[:customerForm] = render_to_string(partial: 'orders/customer_form', locals: { customer: Customer.new })
        else
          json[:selectGameForm] = render_to_string(partial: 'orders/select_game_form')
        end
        render json: json
      else
        render json: {errors: @customer.errors.full_messages.join("\n")}
      end
    else
      render json: {gameForm: render_to_string(partial: 'orders/game_form')}
    end
  end
end
