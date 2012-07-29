class Exotic < Game
  has_gender 'Male', 'Female'
  has_species(
    ['Audad', 'Axis', 'Beef', 'Black Buck', 'Buffalo', 'Eland', 'Fallow',
    'Gemsbok', 'Goat', 'Muflon Sheep', 'Nilgai', 'Oryx', 'Red Stag', 'Sika'],
    custom: true
  )
  has_condition
  has_misc_items ['Save Horns', 'Cape', 'Save Skin', 'Save Head', 'Cape to Go', 'Save Kill Tag']
  has_bow_kill
end
