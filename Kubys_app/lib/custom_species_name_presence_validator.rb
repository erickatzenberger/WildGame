class CustomSpeciesNamePresenceValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if object.species == 'Other' and value.blank?
      object.errors.add(attribute, :presence, options)
    end
  end
end
