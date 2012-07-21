class HuntingLicenceNrTexasFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if object.respond_to?(:origin) and object.origin == 'hunted' and !object.no_hunting_licence_nr
      if !(value =~ /\A\d{12}\Z/)
        object.errors.add(attribute, :hunting_licence_nr_texas_format, options)
      end
    end
  end
end
