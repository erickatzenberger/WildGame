class SteakCut
  self::PARTS = {
    1 => { name: 'Hind Quarters', cuts: {
      1 => { name: 'Whole', sizes: {
        1 => 'Bone-In, Shank-Off',
        2 => 'Bone-In, Shank-On',
        3 => 'Bone-In, Shank-Off, Cut In Half',
        4 => 'Bone-Out, Cut In Half, Netted',
        5 => 'Bone-Out, No Net',
        6 => 'Other'
      }},
      2 => { name: 'Bone-In Steaks', sizes: {
        1 => 'Standard 3/4',
        2 => '1/2',
        3 => '1',
        4 => '1 and 1/4',
        5 => '1 and 1/2',
        6 => '1 and 3/4',
        7 => '2',
        8 => '2 and 1/4',
        9 => '2 and 1/2',
        10 => 'Other',
      }},
      3 => { name: 'Roasts', sizes: {
        1 => 'Boneless, Netted, 2#',
        2 => 'Boneless, Netted, 3#',
        3 => 'Boneless, Netted, 4#',
        4 => 'Boneless, Netted, Other',
        5 => 'Bone-In, 2#',
        6 => 'Bone-In, 3#',
        7 => 'Bone-In, 4#',
        8 => 'Bone-In, Other',
        9 => 'Bone-In, Muscles',
        10 => 'Euro All Muscles',
        11 => 'Top Rounds',
        12 => 'Bottom Rounds',
        13 => 'Eye Rounds',
      }},
      4 => { name: 'Boneless Cutlets', sizes: {
        1 => 'Standard 3/4',
        2 => '1/2',
        3 => '1',
        4 => '1 and 1/4',
        5 => '1 and 1/2',
        6 => '1 and 3/4',
        7 => '2',
        8 => '2 and 1/4',
        9 => '2 and 1/2',
        10 => '3',
        11 => 'Other',
      }},
      5 => { name: 'Tenderized Cutlers', sizes: {
        1 => 'Standard 3/4',
        2 => 'As Thin As Possible',
      }},
      6 => { name: 'Jerky Strips', sizes: {
        1 => 'Standard 3/4',
        2 => 'Cut to Specifications',
      }},
      7 => { name: 'Stew Cubes', sizes: {
        1 => 'Standard 3/4',
        2 => 'Cut to Specifications',
      }},
      8 => { name: 'Fajita Strips', sizes: {
        1 => 'Standard 1/2',
        2 => 'Cut to Specifications',
      }},
      9 => { name: 'Other', sizes: {
        1 => 'Other',
      }},
      10 => { name: 'Grind', sizes: {
        1 => 'Grind',
      }},
    }},
    2 => { name: 'Backstraps', cuts: {
      1 => { name: 'Whole', sizes: {
        1 => 'Keep Whole',
        2 => 'Cut in 1/2',
        3 => 'Cut in 1/3',
        4 => 'Cut in 1/4',
        5 => 'Cut into specific sections length',
        6 => 'Other',
      }},
      2 => { name: 'Butterfly', sizes: {
        1 => 'Standard 3/4',
        2 => '1/2',
        3 => '1',
        4 => '1 and 1/4',
        5 => '1 and 1/2',
        6 => '1 and 3/4',
        7 => '2',
        8 => 'Other',
      }},
      3 => { name: 'Tenderized Butterfly', sizes: {
        1 => 'Standard 3/4',
        2 => 'As Thin As Possible',
      }},
      4 => { name: 'Bone-In Chops', sizes: {
        1 => 'Standard 3/4',
        2 => '1/2',
        3 => '1',
        4 => '1 and 1/4',
        5 => '1 and 1/2',
        6 => '1 and 3/4',
        7 => '2',
        8 => '2 and 1/2',
        9 => 'Other',
      }},
      5 => { name: 'Boneless Filets', sizes: {
        1 => 'Standard 3/4',
        2 => '1/2',
        3 => '1',
        4 => '1 and 1/4',
        5 => '1 and 1/2',
        6 => '1 and 3/4',
        7 => '2',
        8 => '2 and 1/2',
        9 => 'Other',
      }},
      6 => { name: 'Tenderized Filets', sizes: {
        1 => 'Standard 3/4',
        2 => 'As Thin As Possible',
      }},
      7 => { name: 'Standing Rib Roast', sizes: {
        1 => '6',
        2 => '12',
        3 => '18',
        4 => 'Other',
      }},
      8 => { name: 'Jerky Strips', sizes: {
        1 => 'Jerky Strips',
      }},
      9 => { name: 'Stew Cubes', sizes: {
        1 => 'Stew Cubes',
      }},
      10 => { name: 'Other', sizes: {
        1 => 'Other',
      }},
      11 => { name: 'Already Gone', sizes: {
        1 => 'Already Gone',
      }},
      12 => { name: 'Grind', sizes: {
        1 => 'Grind',
      }},
    }},
    3 => { name: 'Tenders', cuts: {
      1 => { name: 'Whole', sizes: {
        1 => 'Keep Whole',
        2 => 'Other',
      }},
      2 => { name: 'Whole Tenderized', sizes: {
        1 => 'Keep Whole Tenderized',
        2 => 'Other',
      }},
      3 => { name: 'Include in Chops', sizes: {
        1 => 'Include in Chops',
        2 => 'Other',
      }},
      4 => { name: 'Jerky Strips', sizes: {
        1 => 'Jerky Strips',
      }},
      5 => { name: 'Stew Cubes', sizes: {
        1 => 'Stew Cubes',
      }},
      6 => { name: 'Other', sizes: {
        1 => 'Other',
      }},
      7 => { name: 'Already Gone', sizes: {
        1 => 'Already Gone',
      }},
      8 => { name: 'Grind', sizes: {
        1 => 'Grind',
      }},
    }},
    4 => { name: 'Ribs', cuts: {
      1 => { name: 'Sections', sizes: {
        1 => 'Sections',
      }},
      2 => { name: 'Whole', sizes: {
        1 => 'Whole',
      }},
      3 => { name: 'Smoking', sizes: {
        1 => 'Smoking',
      }},
      4 => { name: 'Other', sizes: {
        1 => 'Other',
      }},
    }},
    5 => { name: 'Shoulders', cuts: {
      1 => { name: 'Whole', sizes: {
        1 => 'Shank-on',
        2 => 'Shank-off',
      }},
      2 => { name: 'Roasts', sizes: {
        1 => 'Bone-In',
        2 => 'Boneless, Netted',
        3 => 'Other',
      }},
      3 => { name: 'Other', sizes: {
        1 => 'Other',
      }},
    }},
    6 => { name: 'Neck', cuts: {
      1 => { name: 'Whole', sizes: {
        1 => 'Whole',
      }},
      2 => { name: 'Roasts', sizes: {
        1 => 'Roasts',
        2 => 'Smoked',
        3 => 'Wrapping Instructions',
      }},
      3 => { name: 'Steaks', sizes: {
        1 => 'Steaks',
      }},
      4 => { name: 'Smoking', sizes: {
        1 => 'Smoking',
      }},
      5 => { name: 'Other', sizes: {
        1 => 'Other',
      }},
    }},
    7 => { name: 'Others', cuts: {
      1 => { name: 'Other', sizes: {
        1 => 'Other',
        2 => 'Save Bones',
      }},
      2 => { name: 'Smoking', sizes: {
        1 => 'Smoking',
      }},
      3 => { name: 'Save Bones', sizes: {
        1 => 'Save Bones',
      }},
    }},
  }

  include Mongoid::Document
  embedded_in :order

  field :game, type: String

  field :part_id, type: Integer
  field :cut_id, type: Integer
  field :size_id, type: Integer

  field :unit, type: String

  field :number, type: Integer
  field :weight, type: Float

  field :smoking, type: String

  field :reminder, type: Boolean
  field :wrapping, type: String
end
