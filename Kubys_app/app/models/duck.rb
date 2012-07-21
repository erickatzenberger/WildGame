class Duck < Game
  has_species ['Dove', 'Duck', 'Geese', 'Pheasant', 'Quail', 'Sandhill Crane']
  has_origin_data
  has_condition bird_parts: true
  has_misc_items ['Save Kill Tag'], bird: true
end
