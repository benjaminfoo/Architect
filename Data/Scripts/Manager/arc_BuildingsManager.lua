---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020 23:09
---
--- The BuildingsManager is basically a  set of buildings which the player can choose from
--- in order to construct a specific building / entity.
---
--- This file could be used to add further structures which are already implemented in kcd or new assets
---

-- This set contains every creatable construction within the project.
-- This set could be rearranged, your savegame-files wont be affected.
parameterizedConstructions = {

    -- template for new construction / structure
    -- { modelPath = "", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- in dev
    -- generator entity -- water tank / collector --  generates water every 30 seconds
    { modelPath = "Objects/buildings/houses/budin_mill/barrel_01.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false },

    -- generator entity -- some thing to generate stones but in a logical way
    -- ... TODO !

    -- generator entity -- stone collections / someone brings stone in here -- generates stone every 60 seconds
    { modelPath = "objects/nature/rocks/rocks_quarry/stone_granite_group_01.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/gamblers/gamblers_stones_group_a.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false },

    -- generator entity -- wood onuse-generator -- generates wood per hit
    { modelPath = "objects/props/wooden_blocks/chopping_block01.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false },

    -- generator entity -- wood collections / someone brings stone in here -- generates stone every 60 seconds
    -- or maybe generates wood every {60, 30, 15} secs <OR> generate {1,2,3} wood ever  30 secs
    { modelPath = "objects/props/groups_of_stuff/group_woodshed_a.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_woodshed_b.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_woodshed_c.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_woodshed_d.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_woodshed_e.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_woodshed_f.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false },


    { modelPath = "objects/structures/mining_structures/money_forging_workshop/mine_wood_structure.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/mining_structures/roasting_hole_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/mining_structures/roasting_hole_02.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/mining_structures/crushing_mill_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/mining_structures/mining_dam_bridge_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/structures/woodsheds/woodshed_1/woodshed_1.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- furniture - beds
    { modelPath = "objects/props/furniture/beds/bed_cottage_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/props/furniture/beds/bed_castle_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/props/furniture/beds/bed_castle_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/buildings/refugee_camp/bad_straw.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/props/furniture/beds/bed_forest_1.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/props/furniture/beds/bed_infirmarium_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },

    -- furniture - seats, chairs and benches
    { modelPath = "objects/props/furniture/chairs_benches/chair_fancy.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/chairs_benches/bench_10_chair.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/chairs_benches/bench_11_long.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/chairs_benches/church_bench_01.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/chairs_benches/tripod_chair_01.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/chairs_benches/tripod_rounded_01.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/chairs_benches/village_bench140_01bright.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/chairs_benches/village_bench140_01dark.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/chairs_benches/village_bench140_02bright.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/chairs_benches/village_bench140_02dark.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },

    -- furniture - tables
    { modelPath = "objects/props/furniture/tables/table_cottage/table_cottage160_01brigh.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/tables/table_cooking/table_cooking.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/furniture/tables/table_cooking/table_cooking_02.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- custom action entities - cooking spots, generators (use x to make y)
    { modelPath = "objects/structures/bread_oven/bread_oven_01.cgf", sitable = false, useable = false, saveable = false, cookable = true, sleepable = false },
    { modelPath = "objects/structures/bread_oven/bread_oven_02.cgf", sitable = false, useable = false, saveable = false, cookable = true, sleepable = false },
    { modelPath = "objects/structures/bread_oven/bread_oven_indoor.cgf", sitable = false, useable = false, saveable = false, cookable = true, sleepable = false },


    --[[
        -- spawned carpets are spawned too low initially, needs an offset on y-axis (n * {0,1,0})
        { modelPath = "objects/props/carpet/carpet_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
        { modelPath = "objects/props/carpet/carpet_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
        { modelPath = "objects/props/carpet/carpet_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
        { modelPath = "objects/props/.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    ]]

    -- surfaces
    { modelPath = "objects/structures/pillory/pillory_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/pillory/pillory_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },


    -- outside - camp
    { modelPath = "objects/buildings/refugee_camp/camp_wood.cgf", sitable = true, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/refugee_camp/fireplace_empty.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },


    -- tents
    { modelPath = "objects/structures/bath_tent/tent_bath_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/bath_tent/tent_bath_round_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/rataje_bathhouse/bathtub_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/rataje_bathhouse/bathtub_a_water.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/props/interiors/home_content/shelve_homeworks.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "Objects/props/interiors/home_content/pk_group_ceramics.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },

    { modelPath = "objects/structures/tent_cuman/tent_cuman_small_v1.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/structures/tent_cuman/tent_cuman_small_v4.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/structures/tent_cuman/tent_cuman_v1.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/structures/tent_cuman/tent_cuman_v3.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/structures/tent_cuman/tent_cuman_v4.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/structures/tent_cuman/tent_cuman_v5.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },
    { modelPath = "objects/structures/tent_cuman/tent_cuman_v6_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = true },


    -- security - towers
    { modelPath = "objects/props/poi/watchtower.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/palisade_vranik/vranik_palisade_inner_tower.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- gardening / vegetation
    { modelPath = "objects/buildings/sazava_monastery/sm_garden_bed_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- gardening / flowers
    { modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_02.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_03.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_04.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_05.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_mid_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_mid_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_mid_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_d.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_e.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_g.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_h.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/malus/malus_sylvestris_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/trees/salix/salix_cut_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/vegetation/field/plants/ajuga.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/field/plants/alchemilla.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/field/plants/alliaria.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/field/plants/artemisia.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/field/plants/papaver_rhoeas_03.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/vegetation/grass/grass_groups/grass_green_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/grass_green_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/grass_green_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/grass_green_d.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/dry_grass_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/mixed_grass_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/field_wheat_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/marshland_patch_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/marshland_patch_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/marshland_patch_f.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/tall_grass_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/tall_grass_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/tall_grass_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/trifolium_pratense_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/trifolium_pratense_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/trifolium_white_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/grass/grass_groups/trifolium_white_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- gardening - bushes
    { modelPath = "objects/vegetation/bushes/berries/blackberry_bush_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/bushes/berries/blackberry_bush_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/bushes/berries/blueberry_bush_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/bushes/berries/blueberry_bush_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/bushes/berries/raspeberry_bush_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/bushes/berries/raspeberry_bush_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/vegetation/bushes/corylus/corylus_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/bushes/corylus/corylus_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/bushes/crataegus/crataegus_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/bushes/sambucus_nigra/sambucus_nigra_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/bushes/sambucus_nigra/sambucus_nigra_b_flowers.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/vegetation/bushes/rosa/rosa_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- buildings / sheds
    { modelPath = "objects/buildings/houses/shed/shed_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/shed/shed_02.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/shed/shed_03.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/shed/shed_04.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/shed/shed_06.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- buildings / barns
    { modelPath = "objects/buildings/houses/city_barn_02/city_barn_02_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/city_barn_02/city_barn_02_part.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/city_barn_03/city_barn_03.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- props / bridges
    { modelPath = "Objects/structures/bridges/bridge_wooden_05.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/bridges/bridge_wooden_04.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/bridges/bridge_wooden_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/mining_structures/mining_tunnel_sidewalk.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/buildings/sazava_podklasteri/pk_riser_wood.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/bridges/dock_wood_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- props / stairs
    { modelPath = "Objects/vehicles/cart/wooden_curb_stairs.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/stairs/wooden_stairs_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- walls / wooden palisades
    { modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_d.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_e.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_f.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_g.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/wall_wooden/wall_wooden_palisade_gate.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/buildings/churches/church_pribyslawitz/pribyslawitz_beam.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- smithery
    { modelPath = "objects/buildings/houses/smithery/anvil_small.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/smithery/shelf_smithery.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/smithery/smithery.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/smithery/smithery_forge.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/houses/smithery/smithery_forge_v2.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- stairs
    { modelPath = "Objects/structures/stairs/stairs_stone.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/stairs/stone_stairs_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/stairs/stone_stairs_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/structures/stone_wall/stone_wall_uzice_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/stone_wall/stone_wall_uzice_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/stone_wall/stone_wall_uzice_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/stone_wall/stone_wall_uzice_roof_gate.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "Objects/structures/shop/shop_02.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/shop/shop_03.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/shop/shop_v.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/shop/shop_new.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "Objects/structures/woodenouthouse/woodenouthouse.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/structures/woodenouthouse/woodenouthouse_2.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/buildings/sazava_monastery/door_latch.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/buildings/sazava_monastery/furnace.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/sazava_monastery/furnace_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/sazava_monastery/furnace_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- tools
    { modelPath = "objects/props/tools/axe.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/axe_big.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/broom_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/chisel.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/chisel_stone.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/carpenter_axe.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/crubible.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/flail.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/gardenfork.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/hammer.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/histor.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/hoe.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/palicka.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/saw.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/scraper.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/scythe.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/shovel.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/sickle.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/stick.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/tools/tongs.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- lamps & torches
    { modelPath = "objects/props/misc/lamp/lamp_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/lamp/lamp_02.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/torches/torch01_long.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/torches/torch_02.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- props / misc.
    { modelPath = "objects/props/misc/street_props/street_props_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/street_props/street_props_02.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/street_props/street_props_03.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/street_props/street_props_04.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/street_props/street_props_05.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/street_props/street_props_06.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },


    { modelPath = "objects/props/groups_of_stuff/group_sacks_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_sacks_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_sacks_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_sacks_d.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/props/groups_of_stuff/group_hay_pile_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_hay_pile_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_hay_pile_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_hay_pile_d.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/props/groups_of_stuff/group_box_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_box_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_box_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_box_d.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/props/groups_of_stuff/group_shelve_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_shelve_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_shelve_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/props/groups_of_stuff/group_barrels_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_barrels_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_barrels_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/groups_of_stuff/group_barrels_d.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/structures/stone_wall/stone_wall_low_mossy_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/stone_wall/stone_wall_low_mossy_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/stone_wall/stone_wall_low_mossy_d.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/props/fences/fence_01/fence_01_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/fences/fence_01/fence_01_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/fences/fence_01/fence_01_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/nature/stones/dry_stone_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/nature/stones/dry_stone_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/nature/stones/dry_stone_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/nature/stones/dry_stone_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/nature/stones/dry_stone_d.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/buildings/refugee_camp/wicker_fence.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/refugee_camp/wall_timber.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/buildings/refugee_camp/wood_pack.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/vehicles/cart/cart_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/props/misc/icons/icon_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/icons/icon_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/icons/icon_c.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/icons/icon_d.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/icons/icon_e.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/misc/icons/icon_f.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "Objects/vehicles/cart/wooden_curb_01.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/vehicles/cart/wooden_curb_02.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/vehicles/cart/wooden_curb_long_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "Objects/vehicles/cart/wooden_curb_long_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    { modelPath = "objects/structures/brewery/brewery_boiler_a.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/structures/brewery/brewery_boiler_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- misc
    { modelPath = "objects/structures/platforms/wooden_riser_b.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },

    -- exluded stuff, demo-content?
    -- should get exluded maybe
    { modelPath = "objects/props/construction/construction_fence.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/construction/construction_sign.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/construction/dustbin.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/construction/geodetic.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/construction/sign.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/construction/toitoi.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },
    { modelPath = "objects/props/construction/traffic_cone.cgf", sitable = false, useable = false, saveable = false, cookable = false, sleepable = false },


}

--[[

    -- this is used for local tests
    print(#parameterizedConstructions)
    print(parameterizedConstructions[1].modelPath)
    print(parameterizedConstructions[1].sitable)
    print(parameterizedConstructions[1].useable)
    print(parameterizedConstructions[1].saveable)
    print(parameterizedConstructions[1].cookable)
    print(parameterizedConstructions[1].sleepable)

]]
