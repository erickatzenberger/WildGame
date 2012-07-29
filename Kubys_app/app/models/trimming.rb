class Trimming
  include Mongoid::Document
  embedded_in :order

  field :all, type: Boolean
  field :percent, type: String
    validates :percent, format: { with: /\A[0-9]{5}\Z/ }
  field :lb, type: String
    validates :lb, format: { with: /\A[0-9]{5}\Z/ }
  field :split, type: Boolean
  field :remainder, type: Boolean
  
end