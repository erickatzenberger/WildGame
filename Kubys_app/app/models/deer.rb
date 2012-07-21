class Deer < Game
  has_gender 'Buck', 'Doe'
  has_species ['White Tail Deer', 'Pronghorn Antelope', 'Mule Deer']
  has_origin_data kill_tag: true, mldp: true
  has_condition
  has_misc_items ['Save Horns', 'Cape', 'Save Skin', 'Save Head', 'Cape to Go', 'Save Kill Tag']
  has_bow_kill
end
