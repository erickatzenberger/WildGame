class Part
  include Mongoid::Document

  field :name, type: String
  field :quantity, type: Float

  field :other, type: Boolean

  attr_accessor :include

  validates :name, part_name_presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  NAMES = ['Hind Quarters', 'Front Shoulders', 'Intact Saddle',
           'Backstraps', 'Tenders', 'Ribs', 'Neck']
end
