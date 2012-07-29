class Turkey < Game
  has_gender 'Tom', 'Hen'
  has_origin_data kill_tag: true
  has_condition bird_parts: true
  has_misc_items ['Save Beard Only', 'Save Fee and Spurs Only', 'Save Kill Tag'], bird: true
  has_bow_kill
end
