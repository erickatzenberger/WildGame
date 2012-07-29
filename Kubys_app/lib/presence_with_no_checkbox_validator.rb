class PresenceWithNoCheckboxValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if (
      ((object.respond_to?(:origin) and object.origin == options[:origin]) or !object.respond_to?(:origin)) and
      !object.send(options[:checkbox]) and
      value.blank?
    )
      object.errors.add(attribute, :presence, options)
    end
  end
end
