class PartNamePresenceValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if !object.other? and !object.include
      if value.blank?
        object.errors.add(attribute, :presence, options)
      end
    end
  end
end

