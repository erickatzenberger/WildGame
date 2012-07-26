class Trimming
  include Mongoid::Document
  
  embedded_in :order
  
  field :all, type: Boolean
  field :percent, type: String
  field :lb, type: String
  field :split, type: Boolean
  field :remainder, type: Boolean
  
end