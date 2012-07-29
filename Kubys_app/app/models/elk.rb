class Elk < Game
  has_gender 'Bull', 'Cow'
  has_origin_data
  has_condition
  has_misc_items ['Save Horns', 'Cape', 'Save Skin', 'Save Head', 'Cape to Go', 'Save Kill Tag']
  has_bow_kill
end
