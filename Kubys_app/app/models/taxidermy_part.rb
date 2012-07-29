class TaxidermyPart
  include Mongoid::Document
  embedded_in :game

  field :name, type: String
  field :other, type: Boolean

  attr_accessor :include

  validates :name, part_name_presence: true
end
