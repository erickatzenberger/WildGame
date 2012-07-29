class Order
  include Mongoid::Document

  embeds_many :customers
  embeds_many :games
  embeds_many :steak_cuts
  embeds_many :trimmings
end
