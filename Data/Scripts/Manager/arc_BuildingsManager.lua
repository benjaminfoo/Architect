---
--- Created by Benjamin Foo
--- DateTime: 04.03.2020
---
--- The BuildingsManager contains a set of constructions the user is able to choose from
---
--- A construction is an entity within the cryengine
--- There are different kinds of properties an entity can use from
---
--- # Construction, Construction-Properties
--- name (optional) - the name of the construction
--- description     - the description for the construction
--- groschenPrice   - the price in groschen the user has to pay upfront (to whom? who recieves this money) => maybe there should be some kind of logic that 50% goes to the king and 50% to the city, and at some point you will get the money back or something like that, some kind of insurence or something
--- modelPath       - the relative path to the *.cgf file
--- sitable         - if true, the player can sit on this object
--- useable         - if true, the player can use the object in some way
--- saveable        - if true, the instance of the construction gets saved
--- cookable        - if true, the player can use the construction for cooking
--- sleepable       - if true, the player can use the construction for sleeping
---
--- # properties related to generating some item over a specified amount of time
--- # (like collecting water passively) or craft something out of x for y (x = generated item, y = cost of crafting for item x)
--- generator           - if true, the item generates items over time specified by following properties
--- generatorOnUse      - if true, the construction can be used by the player to generate an item
--- generatorItem       - the item that gets crafted on use or after time
--- generatorCooldown   - the length of the intervall after an item gets generated passievly
--- generatorItemAmount - the amount of items the user recieves after an intervall
---
--- Note: constructions which only contain a modelPath are handled as static entites (no functionality, just a model + collider + manged in savegames)
---
---
--- This file could be used to add further structures which are already implemented in kcd or new assets
---
parameterizedConstructions = {

    -- template for new construction / structure
    -- { modelPath = "", },


    -- in dev
    -- generator entity -- water tank / collector --  generates water every 30 seconds
    {
        description = "A barrel for passively collecting water over time.",
        groschenPrice = 300,
        modelPath = "Objects/buildings/houses/budin_mill/barrel_01.cgf",
        sitable = false, useable = true, saveable = false, cookable = false, sleepable = false,
        generator = true, generatorOnUse = false, generatorItem = "water", generatorCooldown = 30, generatorItemAmount = 1
    },


    -- generator entity -- some thing to generate stones but in a logical way
    {
        description = "A small pile of stones",
        groschenPrice = 250,
        modelPath = "objects/nature/rocks/rocks_quarry/stone_granite_group_01.cgf",
        sitable = false, useable = true, saveable = false, cookable = false, sleepable = false,
        generator = true, generatorOnUse = true, generatorItem = "stone", generatorCooldown = 60, generatorItemAmount = 1
    },


    -- generator entity -- stone collections / someone brings stone in here -- generates stone every 60 seconds
    {
        description = "A collection of stones, generates 1 stone every 60 seconds.",
        groschenPrice = 500,
        sitable = false, useable = true, saveable = false, cookable = false, sleepable = false,
        generator = true, generatorOnUse = true, generatorItem = "stone", generatorCooldown = 60, generatorItemAmount = 1
    },


    -- generator entity -- wood onuse-generator -- generates wood per hit
    {
        description = "A wooden block for chopping wood.",
        groschenPrice = 100,
        modelPath = "objects/props/wooden_blocks/chopping_block01.cgf",
        sitable = false, useable = true, saveable = false, cookable = false, sleepable = false,
        generator = true, generatorOnUse = true, generatorItem = "wood", generatorCooldown = 2, generatorItemAmount = 1
    },


    -- generator entity -- wood collections / someone brings stone in here -- generates stone every 60 seconds
    -- or maybe generates wood every {60, 30, 15} secs <OR> generate {1,2,3} wood ever  30 secs
    {
        description = "A pile of wooden logs, consists of at least ten wooden logs.",
        groschenPrice = 250,
        generator = true, generatorOnUse = false, generatorItem = "wood", generatorCooldown = 30, generatorItemAmount = 1,
        sitable = false, useable = true, saveable = false, cookable = false, sleepable = false,
        modelPath = "objects/props/groups_of_stuff/group_woodshed_b.cgf",
    },


    --
    {
        description = "A larger pile of wooden logs, consists of at least ten wooden logs.",
        groschenPrice = 450,
        generator = true, generatorOnUse = false, generatorItem = "wood", generatorCooldown = 30, generatorItemAmount = 1,
        sitable = false, useable = true, saveable = false, cookable = false, sleepable = false,
        modelPath = "objects/props/groups_of_stuff/group_woodshed_e.cgf",
    },


    -- generator entity -- creating coal
    {
        description = "A construction for making coal.",
        modelPath = "objects/structures/mining_structures/roasting_hole_01.cgf",

    },
    {
        description = "A construction for making coal.",
        modelPath = "objects/structures/mining_structures/roasting_hole_02.cgf",

    },


    -- furniture - beds
    {
        description = "A wooden bed for sleeping.",
        groschenPrice = 100,
        modelPath = "objects/props/furniture/beds/bed_cottage_01.cgf",
        sleepable = true
    },
    {
        description = "A wooden bed with pretty blankets and pillows.",
        groschenPrice = 100,
        modelPath = "objects/props/furniture/beds/bed_castle_a.cgf",
        sleepable = true
    },
    {
        description = "A wooden bed with pretty blankets and pillows.",
        groschenPrice = 100,
        modelPath = "objects/props/furniture/beds/bed_castle_b.cgf",
        sleepable = true
    },
    {
        description = "A simple bed made from straw",
        modelPath = "objects/buildings/refugee_camp/bad_straw.cgf",
        sleepable = true
    },
    {
        description = "A simple bed made from wooden sticks",
        modelPath = "objects/props/furniture/beds/bed_forest_1.cgf",
        sleepable = true
    },
    {
        description = "An even nicer bed.",
        modelPath = "objects/props/furniture/beds/bed_infirmarium_01.cgf",
        sleepable = true
    },


    -- furniture - seats, chairs and benches
    {
        description = "A really fancy wooden chair for fancy people.",
        modelPath = "objects/props/furniture/chairs_benches/chair_fancy.cgf",
        sitable = true
    },
    {
        description = "A wooden bench.",
        modelPath = "objects/props/furniture/chairs_benches/bench_10_chair.cgf",
        sitable = true
    },
    {
        description = "A wooden bench.",
        modelPath = "objects/props/furniture/chairs_benches/bench_11_long.cgf",
        sitable = true
    },
    {
        description = "A wooden bench.",
        modelPath = "objects/props/furniture/chairs_benches/church_bench_01.cgf",
        sitable = true
    },
    {
        description = "A wooden tripod chair.",
        modelPath = "objects/props/furniture/chairs_benches/tripod_chair_01.cgf",
        sitable = true
    },
    {
        description = "A wooden bench.",
        modelPath = "objects/props/furniture/chairs_benches/tripod_rounded_01.cgf",
        sitable = true
    },
    {
        description = "A wooden bench.",
        modelPath = "objects/props/furniture/chairs_benches/village_bench140_01bright.cgf",
        sitable = true
    },
    {
        description = "A wooden bench.",
        modelPath = "objects/props/furniture/chairs_benches/village_bench140_01dark.cgf",
        sitable = true
    },
    {
        description = "A wooden bench.",
        modelPath = "objects/props/furniture/chairs_benches/village_bench140_02bright.cgf",
        sitable = true
    },
    {
        description = "A wooden bench.",
        modelPath = "objects/props/furniture/chairs_benches/village_bench140_02dark.cgf",
        sitable = true
    },


    -- furniture - tables
    {
        modelPath = "objects/props/furniture/tables/table_cottage/table_cottage160_01brigh.cgf",
    },
    {
        modelPath = "objects/props/furniture/tables/table_cooking/table_cooking.cgf"
    },
    {
        modelPath = "objects/props/furniture/tables/table_cooking/table_cooking_02.cgf"
    },


    -- custom action entities - cooking spots, generators (use x to make y)
    {
        modelPath = "objects/structures/bread_oven/bread_oven_01.cgf",
        cookable = true,
    },
    {
        modelPath = "objects/structures/bread_oven/bread_oven_02.cgf",
        cookable = true,
    },
    {
        modelPath = "objects/structures/bread_oven/bread_oven_indoor.cgf",
        cookable = true,
    },


    --[[
        -- spawned carpets are spawned too low initially, needs an offset on y-axis + (n * {0,1,0})
        { modelPath = "objects/props/carpet/carpet_a.cgf",  },
        { modelPath = "objects/props/carpet/carpet_b.cgf",  },
        { modelPath = "objects/props/carpet/carpet_c.cgf",  },
        { modelPath = "objects/props/.cgf",  },
    ]]


    -- surfaces
    { modelPath = "objects/structures/pillory/pillory_b.cgf" },
    { modelPath = "objects/structures/pillory/pillory_c.cgf" },


    -- outside - camp
    {
        modelPath = "objects/buildings/refugee_camp/camp_wood.cgf",
        sitable = true
    },


    -- the fire place which could be used for cooking stuff or regularly eat food
    {
        description = "An empty fireplace",
        modelPath = "objects/buildings/refugee_camp/fireplace_empty.cgf",
        cookable = true
    },


    -- tents
    {
        description = "A tent which is frequently used in bath houses.",
        modelPath = "objects/structures/bath_tent/tent_bath_a.cgf",
        sleepable = false
    },
    {
        description = "A tent which is frequently used in bath houses.",
        modelPath = "objects/structures/bath_tent/tent_bath_round_a.cgf",
        sleepable = false
    },
    {
        description = "A tub which is frequently used in bath houses.",
        modelPath = "objects/buildings/houses/rataje_bathhouse/bathtub_a.cgf",
    },
    -- {  modelPath = "objects/buildings/houses/rataje_bathhouse/bathtub_a_water.cgf", },

    {
        description = "A tent often used by cuman soldiers",
        modelPath = "objects/structures/tent_cuman/tent_cuman_small_v1.cgf",
        sleepable = true },
    {
        description = "A tent often used by cuman soldiers",
        modelPath = "objects/structures/tent_cuman/tent_cuman_small_v4.cgf",
        sleepable = true
    },
    {
        description = "A tent often used by cuman soldiers",
        modelPath = "objects/structures/tent_cuman/tent_cuman_v1.cgf",
    },
    {
        description = "A tent often used by cuman soldiers",
        modelPath = "objects/structures/tent_cuman/tent_cuman_v3.cgf",
    },
    {
        description = "A tent often used by cuman soldiers",
        modelPath = "objects/structures/tent_cuman/tent_cuman_v4.cgf",
    },
    {
        description = "A tent often used by cuman soldiers",
        modelPath = "objects/structures/tent_cuman/tent_cuman_v5.cgf",
    },
    {
        description = "A tent often used by cuman soldiers",
        modelPath = "objects/structures/tent_cuman/tent_cuman_v6_b.cgf",
    },


    -- security - towers
    {
        modelPath = "objects/props/poi/watchtower.cgf"
    },
    {
        modelPath = "objects/buildings/palisade_vranik/vranik_palisade_inner_tower.cgf"
    },

    -- gardening / vegetation
    {
        modelPath = "objects/buildings/sazava_monastery/sm_garden_bed_a.cgf",
    },

    -- gardening / flowers
    {
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_01.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_02.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_03.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_04.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_05.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_mid_a.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_mid_b.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_mid_c.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_a.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_b.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_c.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_d.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_e.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_g.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_h.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/malus/malus_sylvestris_a.cgf",
    },
    {
        modelPath = "objects/vegetation/trees/salix/salix_cut_a.cgf",
    },


    {
        modelPath = "objects/vegetation/field/plants/ajuga.cgf",
    },
    {
        modelPath = "objects/vegetation/field/plants/alchemilla.cgf",
    },
    {
        modelPath = "objects/vegetation/field/plants/alliaria.cgf",
    },
    {
        modelPath = "objects/vegetation/field/plants/artemisia.cgf",
    },
    {
        modelPath = "objects/vegetation/field/plants/papaver_rhoeas_03.cgf",
    },


    {
        modelPath = "objects/vegetation/grass/grass_groups/grass_green_a.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/grass_green_b.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/grass_green_c.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/grass_green_d.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/dry_grass_a.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/mixed_grass_a.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/field_wheat_a.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/marshland_patch_a.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/marshland_patch_b.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/marshland_patch_f.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/tall_grass_a.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/tall_grass_b.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/tall_grass_c.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/trifolium_pratense_a.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/trifolium_pratense_b.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/trifolium_white_a.cgf",
    },
    {
        modelPath = "objects/vegetation/grass/grass_groups/trifolium_white_b.cgf",
    },

    -- gardening - bushes
    {
        modelPath = "objects/vegetation/bushes/berries/blackberry_bush_a.cgf" },
    {
        modelPath = "objects/vegetation/bushes/berries/blackberry_bush_b.cgf" },
    {
        modelPath = "objects/vegetation/bushes/berries/blueberry_bush_a.cgf" },
    {
        modelPath = "objects/vegetation/bushes/berries/blueberry_bush_b.cgf" },
    {
        modelPath = "objects/vegetation/bushes/berries/raspeberry_bush_a.cgf" },
    {
        modelPath = "objects/vegetation/bushes/berries/raspeberry_bush_b.cgf" },

    {
        modelPath = "objects/vegetation/bushes/corylus/corylus_b.cgf" },
    {
        modelPath = "objects/vegetation/bushes/corylus/corylus_c.cgf" },
    {
        modelPath = "objects/vegetation/bushes/crataegus/crataegus_a.cgf" },
    {
        modelPath = "objects/vegetation/bushes/sambucus_nigra/sambucus_nigra_b.cgf" },
    {
        modelPath = "objects/vegetation/bushes/sambucus_nigra/sambucus_nigra_b_flowers.cgf" },
    {
        modelPath = "objects/vegetation/bushes/rosa/rosa_a.cgf" },

    -- buildings / sheds
    {
        description "A shed made out of wood and stone. ",
        modelPath = "objects/buildings/houses/shed/shed_01.cgf",
    },
    {
        description "A shed made out of wood and stone. ",
        modelPath = "objects/buildings/houses/shed/shed_02.cgf",
    },
    {
        description "A shed made out of wood and stone. ",
        modelPath = "objects/buildings/houses/shed/shed_03.cgf",
    },
    {
        description "A shed made out of wood and stone. ",
        modelPath = "objects/buildings/houses/shed/shed_04.cgf",
    },
    {
        description "A shed made out of wood and stone. ",
        modelPath = "objects/buildings/houses/shed/shed_06.cgf",
    },
    {
        description "A shed made out of wood and stone. ",
        modelPath = "objects/structures/woodsheds/woodshed_1/woodshed_1.cgf",
    },

    -- buildings / barns
    {
        modelPath = "objects/buildings/houses/city_barn_02/city_barn_02_b.cgf",
    },
    {
        modelPath = "objects/buildings/houses/city_barn_02/city_barn_02_part.cgf",
    },
    {
        modelPath = "objects/buildings/houses/city_barn_03/city_barn_03.cgf",
    },


    {
        description = "Part of a structure which is used with mills.",
        modelPath = "objects/structures/mining_structures/crushing_mill_01.cgf",
    },

    -- props / bridges
    {
        modelPath = "Objects/structures/bridges/bridge_wooden_05.cgf",
    },
    {
        modelPath = "Objects/structures/bridges/bridge_wooden_04.cgf",
    },
    {
        modelPath = "Objects/structures/bridges/bridge_wooden_01.cgf",
    },
    {
        modelPath = "Objects/structures/mining_structures/mining_tunnel_sidewalk.cgf",
    },
    {
        modelPath = "Objects/buildings/sazava_podklasteri/pk_riser_wood.cgf",
    },
    {
        modelPath = "Objects/structures/bridges/dock_wood_a.cgf",
    },
    {
        modelPath = "objects/structures/mining_structures/mining_dam_bridge_01.cgf",
    },

    -- props / stairs
    {
        modelPath = "Objects/vehicles/cart/wooden_curb_stairs.cgf",
    },
    {
        modelPath = "Objects/structures/stairs/wooden_stairs_b.cgf",
    },

    -- walls / wooden palisades
    {
        modelPath = "objects/structures/mining_structures/money_forging_workshop/mine_wood_structure.cgf",
    },

    {
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_a.cgf" },
    {
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_b.cgf", },
    {
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_c.cgf", },
    {
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_d.cgf", },
    {
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_e.cgf", },
    {
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_f.cgf",
    },
    {
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_g.cgf",
    },
    {
        modelPath = "Objects/structures/wall_wooden/wall_wooden_palisade_gate.cgf",
    },
    {
        modelPath = "Objects/buildings/churches/church_pribyslawitz/pribyslawitz_beam.cgf",
    },

    -- smithery
    {
        modelPath = "objects/buildings/houses/smithery/anvil_small.cgf",
    },
    {
        modelPath = "objects/buildings/houses/smithery/shelf_smithery.cgf",
    },
    {
        modelPath = "objects/buildings/houses/smithery/smithery.cgf",
    },
    {
        modelPath = "objects/buildings/houses/smithery/smithery_forge.cgf",
    },
    {
        modelPath = "objects/buildings/houses/smithery/smithery_forge_v2.cgf",
    },

    -- stairs
    {
        modelPath = "Objects/structures/stairs/stairs_stone.cgf",
    },
    {
        modelPath = "Objects/structures/stairs/stone_stairs_a.cgf",
    },
    {
        modelPath = "Objects/structures/stairs/stone_stairs_b.cgf",
    },

    {
        modelPath = "objects/structures/stone_wall/stone_wall_uzice_a.cgf",
    },
    {
        modelPath = "objects/structures/stone_wall/stone_wall_uzice_b.cgf",
    },
    {
        modelPath = "objects/structures/stone_wall/stone_wall_uzice_c.cgf",
    },
    {
        modelPath = "objects/structures/stone_wall/stone_wall_uzice_roof_gate.cgf",
    },

    {
        modelPath = "Objects/structures/shop/shop_02.cgf",
    },
    {
        modelPath = "Objects/structures/shop/shop_03.cgf",
    },
    {
        modelPath = "Objects/structures/shop/shop_v.cgf",
    },
    {
        modelPath = "Objects/structures/shop/shop_new.cgf",
    },

    {
        modelPath = "Objects/structures/woodenouthouse/woodenouthouse.cgf",
    },
    {
        modelPath = "Objects/structures/woodenouthouse/woodenouthouse_2.cgf",
    },

    {
        modelPath = "objects/buildings/sazava_monastery/door_latch.cgf",
    },

    {
        modelPath = "objects/buildings/sazava_monastery/furnace.cgf",
    },
    {
        modelPath = "objects/buildings/sazava_monastery/furnace_b.cgf",
    },
    {
        modelPath = "objects/buildings/sazava_monastery/furnace_c.cgf",
    },

    -- tools
    {
        modelPath = "objects/props/tools/axe.cgf",
    },
    {
        modelPath = "objects/props/tools/axe_big.cgf",
    },
    {
        modelPath = "objects/props/tools/broom_01.cgf",
    },
    {
        modelPath = "objects/props/tools/chisel.cgf",
    },
    {
        modelPath = "objects/props/tools/chisel_stone.cgf",
    },
    {
        modelPath = "objects/props/tools/carpenter_axe.cgf",
    },
    {
        modelPath = "objects/props/tools/crubible.cgf",
    },
    {
        modelPath = "objects/props/tools/flail.cgf",
    },
    {
        modelPath = "objects/props/tools/gardenfork.cgf",
    },
    {
        modelPath = "objects/props/tools/hammer.cgf",
    },
    {
        modelPath = "objects/props/tools/histor.cgf",
    },
    {
        modelPath = "objects/props/tools/hoe.cgf",
    },
    {
        modelPath = "objects/props/tools/palicka.cgf",
    },
    {
        modelPath = "objects/props/tools/saw.cgf",
    },
    {
        modelPath = "objects/props/tools/scraper.cgf",
    },
    {
        modelPath = "objects/props/tools/scythe.cgf",
    },
    {
        modelPath = "objects/props/tools/shovel.cgf",
    },
    {
        modelPath = "objects/props/tools/sickle.cgf",
    },
    {
        modelPath = "objects/props/tools/stick.cgf",
    },
    {
        modelPath = "objects/props/tools/tongs.cgf",
    },

    -- lamps & torches
    {
        modelPath = "objects/props/misc/lamp/lamp_01.cgf",
    },
    {
        modelPath = "objects/props/misc/lamp/lamp_02.cgf",
    },
    {
        modelPath = "objects/props/misc/torches/torch01_long.cgf",
    },
    {
        modelPath = "objects/props/misc/torches/torch_02.cgf",
    },

    {
        modelPath = "objects/props/groups_of_stuff/group_woodshed_a.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_woodshed_d.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_woodshed_f.cgf", sitable = false, useable = true, saveable = false, cookable = false, sleepable = false
    },
    -- props / misc.
    {
        modelPath = "objects/props/misc/street_props/street_props_01.cgf",
    },
    {
        modelPath = "objects/props/misc/street_props/street_props_02.cgf",
    },
    {
        modelPath = "objects/props/misc/street_props/street_props_03.cgf",
    },
    {
        modelPath = "objects/props/misc/street_props/street_props_04.cgf",
    },
    {
        modelPath = "objects/props/misc/street_props/street_props_05.cgf",
    },
    {
        modelPath = "objects/props/misc/street_props/street_props_06.cgf",
    },


    {
        modelPath = "objects/props/groups_of_stuff/group_sacks_a.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_sacks_b.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_sacks_c.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_sacks_d.cgf",
    },

    {
        modelPath = "objects/props/groups_of_stuff/group_hay_pile_a.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_hay_pile_b.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_hay_pile_c.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_hay_pile_d.cgf",
    },

    {
        modelPath = "objects/props/groups_of_stuff/group_box_a.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_box_b.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_box_c.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_box_d.cgf",
    },

    {
        modelPath = "objects/props/groups_of_stuff/group_shelve_a.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_shelve_b.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_shelve_c.cgf",
    },

    {
        modelPath = "objects/props/groups_of_stuff/group_barrels_a.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_barrels_b.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_barrels_c.cgf",
    },
    {
        modelPath = "objects/props/groups_of_stuff/group_barrels_d.cgf",
    },

    {
        modelPath = "objects/structures/stone_wall/stone_wall_low_mossy_b.cgf",
    },
    {
        modelPath = "objects/structures/stone_wall/stone_wall_low_mossy_c.cgf",
    },
    {
        modelPath = "objects/structures/stone_wall/stone_wall_low_mossy_d.cgf",
    },

    {
        modelPath = "objects/props/fences/fence_01/fence_01_a.cgf",
    },
    {
        modelPath = "objects/props/fences/fence_01/fence_01_b.cgf",
    },
    {
        modelPath = "objects/props/fences/fence_01/fence_01_c.cgf",
    },

    {
        modelPath = "objects/nature/stones/dry_stone_a.cgf",
    },
    {
        modelPath = "objects/nature/stones/dry_stone_a.cgf",
    },
    {
        modelPath = "objects/nature/stones/dry_stone_b.cgf",
    },
    {
        modelPath = "objects/nature/stones/dry_stone_c.cgf",
    },
    {
        modelPath = "objects/nature/stones/dry_stone_d.cgf",
    },

    {
        modelPath = "objects/buildings/refugee_camp/wicker_fence.cgf",
    },
    {
        modelPath = "objects/buildings/refugee_camp/wall_timber.cgf",
    },
    {
        modelPath = "objects/buildings/refugee_camp/wood_pack.cgf",
    },

    {
        modelPath = "objects/vehicles/cart/cart_01.cgf",
    },

    {
        modelPath = "objects/props/misc/icons/icon_a.cgf",
    },
    {
        modelPath = "objects/props/misc/icons/icon_b.cgf",
    },
    {
        modelPath = "objects/props/misc/icons/icon_c.cgf",
    },
    {
        modelPath = "objects/props/misc/icons/icon_d.cgf",
    },
    {
        modelPath = "objects/props/misc/icons/icon_e.cgf",
    },
    {
        modelPath = "objects/props/misc/icons/icon_f.cgf",
    },

    {
        modelPath = "Objects/vehicles/cart/wooden_curb_01.cgf",
    },
    {
        modelPath = "Objects/vehicles/cart/wooden_curb_02.cgf",
    },
    {
        modelPath = "Objects/vehicles/cart/wooden_curb_long_a.cgf",
    },
    {
        modelPath = "Objects/vehicles/cart/wooden_curb_long_b.cgf",
    },

    {
        modelPath = "objects/structures/brewery/brewery_boiler_a.cgf",
    },
    {
        modelPath = "objects/structures/brewery/brewery_boiler_b.cgf",
    },

    -- furniture -- inner furniture and decorations
    {
        modelPath = "Objects/props/interiors/home_content/shelve_homeworks.cgf"
    },
    {
        modelPath = "Objects/props/interiors/home_content/pk_group_ceramics.cgf"
    },

    -- misc
    {
        modelPath = "objects/structures/platforms/wooden_riser_b.cgf",
    },

    -- exluded stuff, demo-content?
    -- should get exluded maybe
    {
        modelPath = "objects/props/construction/construction_fence.cgf",
    },
    {
        modelPath = "objects/props/construction/construction_sign.cgf",
    },
    {
        modelPath = "objects/props/construction/dustbin.cgf",
    },
    {
        modelPath = "objects/props/construction/geodetic.cgf",
    },
    {
        modelPath = "objects/props/construction/sign.cgf",
    },
    {
        modelPath = "objects/props/construction/toitoi.cgf",
    },
    {
        modelPath = "objects/props/construction/traffic_cone.cgf",
    }

}

function updateBuildings()

    bIndex = 1

    for index = 1, #parameterizedConstructions do

        construction = parameterizedConstructions[index]

        -- remove the postfix ending ".cgf" from the name
        construction.name = parameterizedConstructions[index].modelPath
        -- construction.name = string.gsub(parameterizedConstructions[index].modelPath, ".cgf", "")

        -- locate the index of the last /
        -- lastIndex = string.find(construction.name , "/[^/]*$")

        -- create a substring of from the stripped down modelPath
        -- parameterizedConstructions[index].name = string.sub(construction.name, lastIndex + 1)
        parameterizedConstructions[index].name = construction.name

    end

    System.LogAlways("updateBuildings has been called!")

end
updateBuildings()


-- this method can be used to  and their ids
function search(searchName)

    matchId = -1

    for index = 1, #parameterizedConstructions do

        construction = parameterizedConstructions[index]

        -- remove the postfix ending ".cgf" from the name
        -- construction.name = string.gsub(parameterizedConstructions[index].modelPath, ".cgf", "")

        -- locate the index of the last /
        --lastIndex = string.find(construction.name , "/[^/]*$")

        -- create a substring of from the stripped down modelPath
        --construction.name = string.sub(construction.name, lastIndex)

        if (construction.name ~= nil) then

            -- if there is an object with the same name as the construction name (both to lower) ...
            if string.find(string.lower(construction.name), string.lower(searchName)) then
                matchId = index
                log(matchId .. ".) " .. construction.name)
            else

            end

        end

    end

end
