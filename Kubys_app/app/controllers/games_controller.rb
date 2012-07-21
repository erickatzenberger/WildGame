class GamesController < ApplicationController
  def create
    @order = Order.find params[:order_id]
    @game = Game.new_of_type(params[:type], params[:game])

    if @game.valid?
      @order.games << @game
      @order.save
      render json: {
        gamesTable: render_to_string(partial: 'orders/games', locals: { games: @order.games }),
        selectGameForm: render_to_string(partial: 'orders/select_game_form'),
      }
    else
      render json: {errors: @game.errors.full_messages.join("\n")}
    end
  end

  def form
    @order = Order.find params[:order_id]
    @game = Game.new_of_type(params[:type]).set_default_attrs
    render json: {
      gameForm: render_to_string(partial: 'orders/game_form', locals: {type: params[:type]})
    }
  end

  def select_form
    @order = Order.find params[:order_id]
    render partial: 'orders/select_game_form'
  end
end
