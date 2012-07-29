class Pig < Game
  has_gender 'Boar', 'Sow'
  has_species ['Feral Hog', 'Domestic Pig']
  has_condition
  has_misc_items ['Cape', 'Save Skin', 'Save Head', 'Cape to Go', 'Save Kill Tag']
  has_bow_kill
end
