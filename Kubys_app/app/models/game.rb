class Game
  include Mongoid::Document
  embedded_in :order

  # Get class of particular animal by class name
  def self.new_of_type(type, attrs={})
    {
      'deer'   => Deer,
      'pig'    => Pig,
      'duck'   => Duck,
      'turkey' => Turkey,
      'elk'    => Elk,
      'exotic' => Exotic
    }[type].new attrs
  end

  def self.has_gender(male, female)
    class_eval %{GENDERS = { 'male' => male, 'female' => female }}
    field :gender, type: String
    validates :gender, presence: true
  end

  def self.has_species(species, options={})
    if options[:custom]
      species << 'Other'
      field :custom_species_name, type: String
      validates :custom_species_name, custom_species_name_presence: true
    end

    class_eval %{SPECIES = species}
    field :species, type: String
    validates :species, presence: true
  end

  def self.has_origin_data(options={})
    class_eval %{STATES = [
    'Alabama', 'Alaska', 'Arizona', 'California', 'Colorado', 'Connecticut', 'Delaware',
    'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky',
    'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Mississipi', 'Missouri',
    'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York',
    'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island',
    'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Virginia', 'Washington',
    'West Virgia', 'Wisconsin']}
    field :state, type: String
    validates :state, presence: true

    if options[:kill_tag] and options[:mldp]
      field :origin, type: String
    end

    field :hunting_licence_nr, type: String
    field :no_hunting_licence_nr, type: Boolean
    validates :hunting_licence_nr, {
      presence_with_no_checkbox: { checkbox: 'no_hunting_licence_nr', origin: 'hunted' },
      format: { with: /\A\d+\Z/, allow_blank: true },
      hunting_licence_nr_texas_format: true,
    }

    if options[:kill_tag]
      field :kill_tag, type: Integer
      field :no_kill_tag, type: Boolean
      validates :kill_tag, {
        presence_with_no_checkbox: { checkbox: 'no_kill_tag', origin: 'hunted' },
        format: { with: /\A\d+\Z/, allow_blank: true },
      }
    end

    if options[:mldp]
      field :mldp, type: Integer
      field :no_mldp, type: Boolean
      validates :mldp, {
        presence_with_no_checkbox: { checkbox: 'no_mldp', origin: 'mldp' },
        format: { with: /\A\d+\Z/, allow_blank: true },
      }
    end
  end

  def self.has_condition(options={})
    field :condition, type: String

    unless options[:bird_parts]
      parts = ['Skin On', 'Skin Off', 'Whole, Broken Down', 'Parts', 'Boneless']
    else
      parts = ['Skin On', 'Skin Off Whole', 'Bone In Breasts', 'Boneless', 'Frozen in Water']
    end
    parts << 'Unable To Describe'

    class_eval %{CONDITIONS = parts}
    embeds_many :parts
    accepts_nested_attributes_for :parts

    field :weight, type: Float
    validates_numericality_of :weight, greater_than: 0, allow_nil: true
    field :unable_to_weigh, type: Boolean 
    
  end

  field :lugs_quantity, type: Integer

  field :ice_chests_quantity, type: Integer
  field :frozen_in_ice_chest, type: Boolean
  validates :weight, {
    presence_with_no_checkbox: { checkbox: 'frozen_in_ice_chest' },
    format: { with: /\A\d+\Z/, allow_blank: true },
  }

  validates_numericality_of :lugs_quantity, :ice_chests_quantity,
    only_integer: true, greater_than: 0, allow_nil: true

  def self.has_misc_items(misc_items, options={})
    misc_items_hash = {}
    misc_items.each do |item|
      misc_items_hash[item.downcase.gsub(/ /, '_')] = item
    end
    class_eval %{MISC_ITEMS = misc_items_hash}

    # Define Misc. Items
    misc_items_hash.each do |item_id, item|
      field item_id, type: Boolean
    end


    field :save_nothing, type: Boolean

    embeds_many :taxidermy_parts
    accepts_nested_attributes_for :taxidermy_parts

    class_eval %{DEFAULT_TAXIDERMY_PARTS =
      options[:bird] ? ['Whole Bird'] : ['Cape', 'Head']}

    field :county, type: String
    field :ranch, type: String
  end

  def self.has_bow_kill
    field :bow_kill, type: Boolean
  end

  field :notes, type: String

  # Build default game for form
  def set_default_attrs
    self.state = 'Texas' if self.respond_to? :state
    self.origin = 'hunted' if self.respond_to? :origin
    self.gender = 'male' if self.respond_to? :gender
    if self.respond_to? :parts
      parts = Part::NAMES.map { |part_name| {name: part_name} }
      parts << { other: true }
      self.parts = parts
    end
    if self.respond_to? :taxidermy_parts
      taxidermy_parts = self.class::DEFAULT_TAXIDERMY_PARTS.map { |part_name| {name: part_name} }
      taxidermy_parts << { other: true }
      self.taxidermy_parts = taxidermy_parts
    end
    self
  end

  # Get Game misc items
  def misc_items
    misc_items_names = self.class::MISC_ITEMS.map { |index, item|
      self.send(index) ? item : nil
    }
    misc_items_names.delete(nil)
    misc_items_names
  end
end
