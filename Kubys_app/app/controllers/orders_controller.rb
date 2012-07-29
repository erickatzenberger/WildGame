class OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.new
  end

  def edit
    @order = Order.find params[:id]
    @customer = Customer.new
  end

  def create
    @order = Order.new params[:order]
    if @order.save
      json = {
        bioTable: render_to_string(partial: 'bio'),
        url: edit_order_path(@order),
        gameForm: render_to_string(partial: 'game_form'),
      }
      render json: json
    else
      render json: {errors: @order.errors.full_messages.join("\n")}
    end
  end

  def geocode_zip
    location = Geokit::Geocoders::GoogleGeocoder.geocode "#{params[:zip]}, United States"
    puts location
    response_data = {}
    if location.country == 'USA'
      response_data[:state] = location.state ? location.state.strip : nil
      response_data[:city]  = location.city ? location.city.strip : nil
    end
    render json: response_data
  end

  def remote
    require "net/http"
    require "uri"
    uri = URI.parse('http://www.zuvnir.com/kubys/customers_ajax.php')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({sid: rand(100000), section: params[:section], fzip: params[:zip], fstatecode: params[:state]})
    response = http.request(request)
    render text: response.body
  end

  def steak_cuts
    @order = Order.find params[:id]
    render partial: 'steak_cuts'
  end

  def steak_cuts_cuts
    cuts = SteakCut::PARTS[params[:part_id].to_i][:cuts]
    render partial: 'steak_cuts_cuts', locals: { cuts: cuts }
  end

  def steak_cuts_sizes
    sizes = SteakCut::PARTS[params[:part_id].to_i][:cuts][params[:cut_id].to_i][:sizes]
    render partial: 'steak_cuts_sizes', locals: { sizes: sizes }
  end

  def trimmings
    @order = Order.find params[:id]
    render partial: 'trimmings'
  end
end
