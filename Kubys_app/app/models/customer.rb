class Customer
  include Mongoid::Document

  embedded_in :order

  ATTRS = [:first_name, :last_name, :city, :state, :zip, :mobile, :home_mobile, :work_mobile, :email]

  field :first_name,  type: String
  field :last_name,   type: String
  validates_format_of :first_name, :last_name, with: /\A([^\d`~!@#\$%^&*\(\)_\+={}\[\];:'"\?<>,\/\\])+\Z/

  field :street,      type: String

  field :zip,         type: String
  validates :zip, format: { with: /\A[0-9]{5}\Z/ }

  field :city,        type: String

  field :state,       type: String
  validates :state, format: { with: /\A[A-Z]{2}\Z/ }

  field :mobile,      type: String
  field :home_mobile, type: String
  validates_format_of :mobile, :home_mobile, with: /\A\(\d{3}\) \d{3}-\d{4}\Z/, allow_blank: true

  field :work_mobile, type: String
  validates_format_of :work_mobile, with: /\A\(\d{3}\) \d{3}-\d{4}( x\d{1,5})?\Z/, allow_blank: true

  field :send_text_to_mobile, type: Boolean

  field :email, type: String
  validates_format_of :email, with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, allow_blank: true

  validates_presence_of :first_name, :last_name, :street, :zip, :city, :state, :mobile

  field :discount, type: Boolean

  def full_name
    [self.first_name, self.last_name].join(' ')
  end
end
