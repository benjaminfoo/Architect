---
--- Author:  Benjamin Foo
--- DateTime: 04.03.2020
---
--- The BuildingsManager contains a set of constructions the user is able to choose from
---
--- A construction is an entity within the cryengine
--- There are different kinds of properties an entity can use from
---
--- # Construction, Construction-Properties
--- name (optional) - the name of the construction - the name will be built from the modelPath
--- modelPath       - the relative path to the *.cgf file, contains the name of the model file and its physics
--- description     - the description for the construction
--- groschenPrice   - the price in groschen the user has to pay upfront (to whom? who recieves this money) => maybe there should be some kind of logic that 50% goes to the king and 50% to the city, and at some point you will get the money back or something like that, some kind of insurence or something
--- sitable         - if true, the player can sit on this object
--- useable         - if true, the player can use the object in some way
--- saveable        - if true, the instance of the construction gets saved
--- cookingSpot        - if true, the player can use the construction for cooking
--- sleepable       - if true, the player can use the construction for sleeping
---
--- # properties related to generating some item over a specified amount of time
--- # (like collecting water passively) or craft something out of x for y (x = generated item, y = cost of crafting for item x)
--- generator           - if true, the item generates items over time specified by following properties
--- generatorOnUse      - if true, the construction can be used by the player to generate an item
--- generatorItem       - the item that gets crafted on use or after time
--- generatorItemCosts  - the costs for producing this item (a set of resources and amounts)
--- generatorCooldown   - the length of the intervall after an item gets generated passievly
--- generatorItemAmount - the amount of items the user recieves after an intervall
--- generatorCapacity   - the maximum amount this generator can produce ( value = -1 means unlimited)
---
--- Note: constructions which only contain a modelPath are handled as static entites (no functionality, just a model + collider + manged in savegames)
---
---
--- This file could be used to add further structures which are already implemented in kcd or new assets
---

-- categories (currently descriptions) for constructions
DESC_DECO = "Decoration"
DESC_CAT_TREES = "Trees"
DESC_CAT_FLOWERS = "Flowers"
DESC_CAT_BUSHES = "Bushes"
DESC_CAT_WOODEN_STAIRS = "Wooden stairs"
DESC_CAT_STONE_STAIRS = "Stairs made out of stone."
DESC_STONE_WALLS = "Walls made out of stone."
DESC_CAT_SACKS_GROUP = "A group of sacks."
DESC_CAT_GROUP_BOXES = "A group of boxes."
DESC_CAT_GROUP_SHELVES = "A group of shelves and items"
DESC_CAT_GRASS_GROUP = "Grass patches"
DESC_CAT_GROUP_BARRELS = "A group of barrels."

----------------------------------
-- Pricing and groschen details --
-- TODO
--  - this isnt balanced at all
--  - this isnt used at all
----------------------------------
DEFAULT_PRICING_CATEGORY_1 = { 5, 249 }
DEFAULT_PRICING_CATEGORY_2 = { 250, 999 }
DEFAULT_PRICING_CATEGORY_3 = { 1000, 1999 }
DEFAULT_PRICING_CATEGORY_4 = { 2000, 4999 }
DEFAULT_PRICING_CATEGORY_5 = { 5000, 10000 }
DEFAULT_PRICING_CATEGORY_6 = { 10001 }

-- category prices until further balancing happened
DEFAULT_PRICE_BEDS = 250
DEFAULT_PRICE_CHAIRS = 250
DEFAULT_PRICE_WALLS = 250
DEFAULT_PRICE_STAIRS = 250
DEFAULT_PRICE_FLOWER_SIMPLE = 250
DEFAULT_PRICE_FLOWER_ADVANCED = 250

-- set of available constructions
parameterizedConstructions = {

    -- constructions which are under active development are the first in this list
    -- dev misc


    {
        modelPath = "objects/props/ceramics/bowl_03.cgf",
    },

    {
        modelPath = "objects/props/ceramics/bowl_05.cgf",
    },

    {
        modelPath = "objects/props/ceramics/vase_01.cgf",
    },

    {
        modelPath = "objects/props/ceramics/vase_03.cgf",
    },

    {
        modelPath = "objects/props/ceramics/vase_05.cgf",
    },
    {
        modelPath = "objects/props/ceramics/demijohn_01.cgf",
    },
    {
        modelPath = "objects/props/ceramics/demijohn_02.cgf",
    },
    {
        modelPath = "objects/props/ceramics/pot_01.cgf",
    },
    {
        modelPath = "objects/props/ceramics/pot_02.cgf",
    },
    {
        modelPath = "objects/props/ceramics/pan_01.cgf",
    },
    {
        modelPath = "objects/props/ceramics/pan_02.cgf",
    },
    {
        modelPath = "objects/props/ceramics/ceramics_set_basket_01.cgf",
    },

    {
        modelPath = "objects/props/ceramics/ceramics_set_table_02.cgf",
    },

    {
        modelPath = "objects/props/ceramics/ceramics_set_table_03.cgf",
    },


    {
        modelPath = "objects/props/coal/coal_pile_c.cgf",
    },


    {
        modelPath = "objects/props/clothes_line/clothes_line_01_a_deform.cgf",
    },


    {
        modelPath = "objects/props/clothes_line/clothes_line_01_a_deform.cgf",
    },


    {
        modelPath = "objects/props/clothes_line/clothes_line_02.cgf",
    },

    {
        modelPath = "objects/props/clothes_line/clothes_line_02f.cgf",
    },

    {
        modelPath = "objects/props/misc/lamp/lamp_01_wearable.cgf",
    },
    {
        modelPath = "objects/props/misc/lamp/lamp_01.cgf",
    },

    {
        modelPath = "objects/props/misc/pillow/pillow.cgf",
    },

    {
        modelPath = "objects/props/misc/sack_leather/sack_leather.cgf",
    },

    {
        modelPath = "objects/props/misc/church_props/chalice_01.cgf",
    },

    {
        modelPath = "objects/props/misc/church_props/chalice_glass_01.cgf",
    },

    {
        modelPath = "objects/props/misc/church_props/chalice_glass_02.cgf",
    },

    {
        modelPath = "objects/props/misc/church_props/chalice_gold_01.cgf",
    },

    {
        modelPath = "objects/props/misc/church_props/chalice_gold_02.cgf",
    },

    {
        modelPath = "objects/props/misc/church_props/chalice_silver_01.cgf",
    },

    {
        modelPath = "objects/props/misc/church_props/chalice_silver_02.cgf",
    },


    {
        modelPath = "objects/props/wooden_benches/wood_bench_single.cgf",
    },

    {
        modelPath = "objects/props/wooden_benches/wood_bench_composite.cgf",
    },

    {
        modelPath = "objects/props/wooden_bins/baskets/basket_01_angular/basket_01_angular.cgf",
    },


    {
        modelPath = "objects/props/wooden_bins/baskets/basket_02/basket_02.cgf",
    },

    {
        modelPath = "objects/props/wooden_bins/baskets/basket_04/basket_04.cgf",
    },
    {
        modelPath = "objects/props/wooden_bins/baskets/basket_05/basket_05.cgf",
    },
    {
        modelPath = "objects/props/wooden_bins/bucket/bucket_water.cgf",
    },
    {
        description = "A wooden water tub to wash yourself.",
        modelPath = "objects/props/wooden_bins/water_tub/water_tub_wide_water.cgf",
        useable = true, useCategory = "wash"
    },

    {
        description = "Another wooden water tub to get yourself clean tidy.",
        modelPath = "objects/props/wooden_bins/water_tub/water_tube_clean_water.cgf",
        useable = true, useCategory = "wash", useCosts = { groschen = 25 }
    },

    {
        description = "A map drawn onto fabric.",
        modelPath = "objects/props/maps/map.cgf",
    },

    -- generator entity
    {
        description = "A hive for bees..",
        modelPath = "objects/props/hive/hive_a.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "honey", generatorItemAmount = 1, generatorCapacity = -1,
        generatorCooldown = 30, generatorItemCosts = { groschen = 750 },
    },
    {
        description = "A hive for bees..",
        modelPath = "objects/props/hive/bee_skep_1.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "honey", generatorItemAmount = 1, generatorCapacity = -1,
        generatorCooldown = 30, generatorItemCosts = { groschen = 750 },
    },

    -- wells
    {
        description = "A well which provides water.",
        modelPath = "objects/buildings/houses/neuhof/neuhof_well.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "water", generatorItemAmount = 1, generatorCapacity = -1,
        generatorCooldown = 3, generatorItemCosts = { groschen = 1500 },
    },

    {
        description = "A part of the butcher-building in ledecko",
        modelPath = "objects/buildings/sazava_monastery/sm_garden_well.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "water", generatorItemAmount = 1, generatorCapacity = -1,
        generatorCooldown = 3, generatorItemCosts = { groschen = 1500 }
    },


    -- in dev
    -- generator entity -- water tank / collector --  generates water every 30 seconds
    {
        description = "A barrel for passively collecting water over time.",
        modelPath = "Objects/buildings/houses/budin_mill/barrel_01.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "water", generatorItemAmount = 1,
        generatorCooldown = 3, generatorItemCosts = { groschen = 300 }
    },


    -- generator entity -- some thing to generate stones but in a logical way
    {
        description = "A small pile of stones.",
        modelPath = "objects/nature/rocks/rocks_quarry/stone_granite_group_01.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "stone", generatorItemAmount = 1,
        generatorCooldown = 10, generatorItemCosts = { groschen = 300 }
    },


    -- generator entity -- stone collections / someone brings stone in here -- generates stone every 60 seconds
    {
        description = "A collection of stones, generates 1 stone every 60 seconds.",
        modelPath = "objects/buildings/gamblers/gamblers_stones_group_a.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "stone", generatorItemAmount = 2,
        generatorCooldown = 15, generatorItemCosts = { groschen = 500 }
    },


    -- generator entity -- wood onuse-generator -- generates wood per hit
    {
        description = "A wooden block for chopping wood.",
        modelPath = "objects/props/wooden_blocks/chopping_block01.cgf",
        saveable = true,
        generator = false, generatorOnUse = true,
        generatorItem = "wood", generatorItemAmount = 1,
        generatorCooldown = 15, generatorItemCosts = { groschen = 250 }
    },


    -- generator entity -- wood collections / someone brings stone in here -- generates stone every 60 seconds
    -- or maybe generates wood every {60, 30, 15} secs <OR> generate {1,2,3} wood ever  30 secs
    {
        description = "A small pile of wooden logs.",
        modelPath = "objects/props/groups_of_stuff/group_woodshed_b.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "wood", generatorItemAmount = 1,
        generatorCooldown = 15, generatorItemCosts = { groschen = 500 }
    },
    {
        description = "A larger pile of wooden logs.",
        modelPath = "objects/props/piles_of_logs/pile_of_logs_01/pile_of_logs_02.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "wood", generatorItemAmount = 3,
        generatorCooldown = 30, generatorItemCosts = { groschen = 1000 }
    },


    -- generator entity -- produce coal, should maybe require wood or groschen to produce?
    {
        description = "A construction for making coal.",
        modelPath = "objects/structures/mining_structures/roasting_hole_02.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "coal", generatorItemAmount = 1,
        generatorCooldown = 3, generatorItemCosts = { groschen = 300 }
    },
    {
        description = "A larger construction for making coal.",
        modelPath = "objects/structures/mining_structures/roasting_hole_01.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "coal", generatorItemAmount = 3,
        generatorCooldown = 45, generatorItemCosts = { groschen = 1000 }
    },
    -- generator entity --
    {
        description = "A pile of wheat.",
        modelPath = "objects/props/groups_of_stuff/group_hay_pile_b.cgf",
        saveable = true,
        generator = true, generatorOnUse = false,
        generatorItem = "wheat", generatorItemAmount = 1,
        generatorCooldown = 20, generatorItemCosts = { groschen = 500 }
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
        groschenPrice = 100,
        modelPath = "objects/buildings/refugee_camp/bad_straw.cgf",
        sleepable = true
    },
    {
        description = "A simple bed made from wooden sticks",
        groschenPrice = 100,
        modelPath = "objects/props/furniture/beds/bed_forest_1.cgf",
        sleepable = true
    },
    {
        description = "An even nicer bed.",
        groschenPrice = 100,
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
        description = "A wooden table for eating or placing things on top of it.",
        modelPath = "objects/props/furniture/tables/table_cottage/table_cottage160_01brigh.cgf",
    },
    {
        description = "A small table.",
        modelPath = "objects/props/furniture/tables/table_cooking/table_cooking.cgf"
    },
    {
        description = "A wooden table for eating or placing things on top of it.",
        modelPath = "objects/props/furniture/tables/table_cooking/table_cooking_02.cgf"
    },


    -- custom action entities - cooking spots, generators (use x to make y)
    {
        description = "An simple oven which can be used to bake bread out of nettles",
        modelPath = "objects/structures/bread_oven/bread_oven_01.cgf",
        cookingSpot = true,
    },
    {
        description = "An simple oven which can be used to bake .. biscuits .. out of nettles",
        modelPath = "objects/structures/bread_oven/bread_oven_02.cgf",
        cookingSpot = true,
    },
    {
        description = "An simple oven which can be used to bake bread out of nettles",
        modelPath = "objects/structures/bread_oven/bread_oven_indoor.cgf",
        cookingSpot = true,
    },
    {
        description = "An oven which can be used to bake bread out of nettles",
        modelPath = "objects/buildings/sazava_monastery/furnace.cgf",
        cookingSpot = true,
    },
    {
        description = "An oven which can be used to bake bread out of nettles",
        modelPath = "objects/buildings/sazava_monastery/furnace_b.cgf",
        cookingSpot = true,
    },
    {
        description = "An oven which can be used to bake bread out of nettles",
        modelPath = "objects/buildings/sazava_monastery/furnace_c.cgf",
        cookingSpot = true,
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

    -- the fire place which could be used for cooking stuff or regularly eat food
    {
        -- TODO: implement this!
        description = "An empty fireplace, currently decoration only.",
        modelPath = "objects/buildings/refugee_camp/fireplace_empty.cgf",
        cookingSpot = true
    },


    -- props / stairs

    {
        description = "A wooden stair",
        modelPath = "Objects/vehicles/cart/wooden_curb_stairs.cgf",
    },
    {
        description = "A wooden stair",
        modelPath = "Objects/structures/stairs/wooden_stairs_b.cgf",
    },

    {
        description = "Multiple levels of stairs and scaffolding.",
        modelPath = "objects/buildings/sazava_monastery/sm_stairs_a.cgf",
    },


    -- props / bridges
    {
        description = "A wooden bridge",
        modelPath = "Objects/structures/bridges/bridge_wooden_05.cgf",
    },
    {
        description = "A wooden bridge",
        modelPath = "Objects/structures/bridges/bridge_wooden_04.cgf",
    },
    {
        description = "A wooden bridge",
        modelPath = "Objects/structures/bridges/bridge_wooden_01.cgf",
    },
    {
        description = "A wooden bridge",
        modelPath = "Objects/structures/mining_structures/mining_tunnel_sidewalk.cgf",
    },
    {
        description = "A wooden bridge",
        modelPath = "Objects/buildings/sazava_podklasteri/pk_riser_wood.cgf",
    },
    {
        description = "A wooden bridge",
        modelPath = "Objects/structures/bridges/dock_wood_a.cgf",
    },
    {
        description = "A wooden bridge",
        modelPath = "objects/structures/mining_structures/mining_dam_bridge_01.cgf",
    },

    -- platforms
    {
        description = "A part of the butcher-building in ledecko",
        modelPath = "objects/buildings/sazava_monastery/sm_platform_a.cgf",
    },
    {
        description = "A part of the butcher-building in ledecko",
        modelPath = "objects/buildings/sazava_monastery/sm_platform_b.cgf",
    },
    {
        description = "A part of the butcher-building in ledecko",
        modelPath = "objects/buildings/sazava_monastery/sm_platform_c.cgf",
    },

    -- bath tents
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

    -- other tents
    {
        description = "A tent used by hunters or people living in the woods.",
        modelPath = "objects/props/poi/hunter_shelter.cgf",
        sleepable = true
    },
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
        description = "A wooden tower - used to get a better overview on battlefields",
        modelPath = "objects/props/poi/watchtower.cgf"
    },
    {
        description = "A wooden tower - used to get a better overview on battlefields",
        modelPath = "objects/buildings/palisade_vranik/vranik_palisade_inner_tower.cgf"
    },

    -- gardening / vegetation
    {
        description = "A box for raising plants",
        modelPath = "objects/buildings/sazava_monastery/sm_garden_bed_a.cgf",
    },


    -- gardening / flowers
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_01.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_02.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_03.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_04.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_05.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_mid_a.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_mid_b.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/fagus_sylvatica/fagus_sylvatica_mid_c.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_a.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_b.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_c.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_d.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_e.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_g.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/betula_pendula/betula_pendula_h.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/malus/malus_sylvestris_a.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/trees/salix/salix_cut_a.cgf",
    },

    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/field/plants/ajuga.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/field/plants/alchemilla.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/field/plants/alliaria.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/field/plants/artemisia.cgf",
    },
    {
        description = DESC_CAT_FLOWERS,
        modelPath = "objects/vegetation/field/plants/papaver_rhoeas_03.cgf",
    },


    -- grass patches
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/grass_green_a.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/grass_green_b.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/grass_green_c.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/grass_green_d.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/dry_grass_a.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/mixed_grass_a.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/field_wheat_a.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/marshland_patch_a.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/marshland_patch_b.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/marshland_patch_f.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/tall_grass_a.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/tall_grass_b.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/tall_grass_c.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/trifolium_pratense_a.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/trifolium_pratense_b.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/trifolium_white_a.cgf",
    },
    {
        description = DESC_CAT_GRASS_GROUP,
        modelPath = "objects/vegetation/grass/grass_groups/trifolium_white_b.cgf",
    },

    -- gardening - bushes
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/berries/blackberry_bush_a.cgf" },
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/berries/blackberry_bush_b.cgf" },
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/berries/blueberry_bush_a.cgf" },
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/berries/blueberry_bush_b.cgf" },
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/berries/raspeberry_bush_a.cgf" },
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/berries/raspeberry_bush_b.cgf"
    },
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/corylus/corylus_b.cgf"
    },
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/corylus/corylus_c.cgf"
    },
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/crataegus/crataegus_a.cgf"
    },
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/sambucus_nigra/sambucus_nigra_b.cgf"
    },
    {
        description = DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/sambucus_nigra/sambucus_nigra_b_flowers.cgf"
    },
    {
        description = "Rose " .. DESC_CAT_BUSHES,
        modelPath = "objects/vegetation/bushes/rosa/rosa_a.cgf"
    },

    -- simple / single stones
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


    -- buildings / sheds
    {
        description = "A part of the butcher-building in ledecko",
        modelPath = "objects/buildings/houses/ledecko/ledecko_butcher.cgf",
    },
    {
        description = "A part of the butcher-building in ledecko",
        modelPath = "objects/buildings/houses/ledecko/ledecko_shmithery.cgf",
    },
    {
        description = "A part of the butcher-building in ledecko",
        modelPath = "objects/buildings/houses/ledecko/ledecko_stairs.cgf",
    },
    {
        description = "A part of the butcher-building in ledecko",
        modelPath = "objects/buildings/houses/ledecko/sazava_bakery01.cgf",
    },
    {
        description = "A part of the butcher-building in ledecko",
        modelPath = "objects/buildings/houses/ledecko/sazava_bakery02.cgf",
    },
    {
        description = "A shed made out of wood and stone. ",
        modelPath = "objects/buildings/houses/shed/shed_01.cgf",
    },
    {
        description = "A shed made out of wood and stone. ",
        modelPath = "objects/buildings/houses/shed/shed_02.cgf",
    },
    {
        description = "A shed made out of wood and stone. ",
        modelPath = "objects/buildings/houses/shed/shed_03.cgf",
    },
    {
        description = "A shed made out of wood and stone. ",
        modelPath = "objects/buildings/houses/shed/shed_04.cgf",
    },
    {
        description = "A shed made out of wood and stone. ",
        modelPath = "objects/buildings/houses/shed/shed_06.cgf",
    },
    {
        description = "A shed made out of wood and stone. ",
        modelPath = "objects/structures/woodsheds/woodshed_1/woodshed_1.cgf",
    },

    -- structures - houses
    {
        description = "A wooden house.",
        modelPath = "Objects/structures/woodenouthouse/woodenouthouse.cgf",
    },
    {
        description = "A wooden house.",
        modelPath = "Objects/structures/woodenouthouse/woodenouthouse_2.cgf",
    },

    -- buildings / barns
    {
        description = "A wooden barn commonly used in cities.",
        modelPath = "objects/buildings/houses/city_barn_02/city_barn_02_b.cgf",
    },
    {
        description = "A wooden barn commonly used in cities.",
        modelPath = "objects/buildings/houses/city_barn_02/city_barn_02_part.cgf",
    },
    {
        description = "A wooden barn commonly used in cities.",
        modelPath = "objects/buildings/houses/city_barn_03/city_barn_03.cgf",
    },
    {
        description = "Part of a structure which is used with mills.",
        modelPath = "objects/structures/mining_structures/crushing_mill_01.cgf",
    },


    -- walls / wooden palisades
    {
        description = "A wooden palisade / staircase",
        modelPath = "objects/structures/mining_structures/money_forging_workshop/mine_wood_structure.cgf",
    },
    {
        description = "A wooden palisade large enough to keep your foes away.",
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_a.cgf" },
    {
        description = "A wooden palisade large enough to keep your foes away.",
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_b.cgf", },
    {
        description = "A wooden palisade large enough to keep your foes away.",
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_c.cgf", },
    {
        description = "A wooden palisade large enough to keep your foes away.",
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_d.cgf", },
    {
        description = "A wooden palisade large enough to keep your foes away.",
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_e.cgf", },
    {
        description = "A wooden palisade large enough to keep your foes away.",
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_f.cgf",
    },
    {
        description = "A wooden palisade large enough to keep your foes away.",
        modelPath = "objects/structures/wall_wooden/wall_wooden_palisade_g.cgf",
    },
    {
        description = "A wooden palisade-gate large enough to keep your friends in.",
        modelPath = "Objects/structures/wall_wooden/wall_wooden_palisade_gate.cgf",
    },

    -- walls - stone
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

    -- smithery
    {
        description = "The basic structure of a smithery.",
        modelPath = "objects/buildings/houses/smithery/smithery.cgf",
    },
    {
        description = "A small anville.",
        modelPath = "objects/buildings/houses/smithery/anvil_small.cgf",
    },
    {
        description = "A shelf often used in a smithery.",
        modelPath = "objects/buildings/houses/smithery/shelf_smithery.cgf",
    },
    {
        description = "A forge which every smithery needs.",
        modelPath = "objects/buildings/houses/smithery/smithery_forge.cgf",
    },
    {
        description = "Another beautfiul forge which every smithery needs.",
        modelPath = "objects/buildings/houses/smithery/smithery_forge_v2.cgf",
    },

    -- stairs
    {
        description = DESC_CAT_WOODEN_STAIRS,
        modelPath = "Objects/structures/stairs/stairs_stone.cgf",
    },
    {
        description = DESC_CAT_WOODEN_STAIRS,
        modelPath = "Objects/structures/stairs/stone_stairs_a.cgf",
    },
    {
        description = DESC_CAT_STONE_STAIRS,
        modelPath = "Objects/structures/stairs/stone_stairs_b.cgf",
    },


    -- walls
    {
        description = DESC_STONE_WALLS,
        modelPath = "objects/structures/stone_wall/stone_wall_uzice_a.cgf",
    },
    {
        description = DESC_STONE_WALLS,
        modelPath = "objects/structures/stone_wall/stone_wall_uzice_b.cgf",
    },
    {
        description = DESC_STONE_WALLS,
        modelPath = "objects/structures/stone_wall/stone_wall_uzice_c.cgf",
    },
    {
        description = "A gate made out of thicc stone.",
        modelPath = "objects/structures/stone_wall/stone_wall_uzice_roof_gate.cgf",
    },

    -- shops / markets
    {
        description = "A shop for buying and selling items, equipment or other things.",
        modelPath = "Objects/structures/shop/shop_02.cgf",
    },
    {
        description = "A shop for buying and selling items, equipment or other things.",
        modelPath = "Objects/structures/shop/shop_03.cgf",
    },
    {
        description = "A shop for buying and selling items, equipment or other things.",
        modelPath = "Objects/structures/shop/shop_v.cgf",
    },
    {
        description = "A shop for buying and selling items, equipment or other things.",
        modelPath = "Objects/structures/shop/shop_new.cgf",
    },

    -- shops details
    {
        description = "A wooden counter used by merchants.",
        modelPath = "Objects/props/interiors/specific/merchant/counter_merchant_1.cgf",
    },
    {
        description = "A wooden counter used by butchers",
        modelPath = "Objects/props/interiors/specific/merchant/counter_butcher.cgf",
    },
    {
        description = "A wooden counter used by weaponsmiths",
        modelPath = "Objects/props/interiors/specific/merchant/counter_weaponsmith.cgf",
    },
    {
        description = "A wooden counter used by foodstores",
        modelPath = "Objects/props/interiors/specific/merchant/foodshop_basket_holder.cgf",
    },
    {
        description = "A wooden holder for items.",
        modelPath = "Objects/props/interiors/specific/merchant/sale_desk_merchant_1.cgf",
    },
    {
        description = "A wooden counter used by foodstores",
        modelPath = "Objects/props/interiors/specific/merchant/shelf_merchant_01.cgf",
    },
    {
        description = "A wooden counter used by foodstores",
        modelPath = "Objects/props/interiors/specific/merchant/shelf_merchant_02.cgf",
    },
    {
        description = "A wooden counter used by foodstores",
        modelPath = "Objects/props/interiors/specific/merchant/shelf_merchant_03.cgf",
    },


    -- tools
    {
        description = "An axe for cutting trees or wood logs",
        modelPath = "objects/props/tools/axe.cgf",
    },
    {
        description = "An axe for cutting trees or wood logs",
        modelPath = "objects/props/tools/axe_big.cgf",
    },
    {
        description = "A broom for cleaning ya place",
        modelPath = "objects/props/tools/broom_01.cgf",
    },
    {
        description = "A chisel.",
        modelPath = "objects/props/tools/chisel.cgf",
    },
    {
        description = "A chisel.",
        modelPath = "objects/props/tools/chisel_stone.cgf",
    },
    {
        description = "An axe for carpenter.",
        modelPath = "objects/props/tools/carpenter_axe.cgf",
    },
    {
        description = "An crubible.",
        modelPath = "objects/props/tools/crubible.cgf",
    },
    {
        description = "An flail.",
        modelPath = "objects/props/tools/flail.cgf",
    },
    {
        description = "An gardenfork.",
        modelPath = "objects/props/tools/gardenfork.cgf",
    },
    {
        description = "A hammer for when its hammertime",
        modelPath = "objects/props/tools/hammer.cgf",
    },
    {
        description = "A histor",
        modelPath = "objects/props/tools/histor.cgf",
    },
    {
        description = "A hoe",
        modelPath = "objects/props/tools/hoe.cgf",
    },
    {
        description = "A palicka",
        modelPath = "objects/props/tools/palicka.cgf",
    },
    {
        description = "A saw for trees or wood logs.",
        modelPath = "objects/props/tools/saw.cgf",
    },
    {
        description = "A scrapper.",
        modelPath = "objects/props/tools/scraper.cgf",
    },
    {
        description = "A scythe for cutting grass or wheat.",
        modelPath = "objects/props/tools/scythe.cgf",
    },
    {
        description = "A shovel for digging holes or garden work.",
        modelPath = "objects/props/tools/shovel.cgf",
    },
    {
        description = "A sickle.",
        modelPath = "objects/props/tools/sickle.cgf",
    },

    -- lamps & torches
    {
        description = "A simple lamp",
        groschenPrice = 100,
        modelPath = "objects/props/misc/lamp/lamp_01.cgf",
    },
    {
        description = "An advanced lamp",
        groschenPrice = 300,
        modelPath = "objects/props/misc/lamp/lamp_02.cgf",
    },
    {
        description = "A long torch",
        groschenPrice = 100,
        modelPath = "objects/props/misc/torches/torch01_long.cgf",
    },
    {
        description = "A short torch",
        groschenPrice = 50,
        modelPath = "objects/props/misc/torches/torch_02.cgf",
    },


    -- groups of properties
    {
        description = "A pile of wooden logs",
        modelPath = "objects/props/groups_of_stuff/group_woodshed_a.cgf",
    },
    {
        description = "A pile of wooden logs",
        modelPath = "objects/props/groups_of_stuff/group_woodshed_d.cgf",
    },
    {
        description = "A pile of wooden logs",
        modelPath = "objects/props/groups_of_stuff/group_woodshed_f.cgf",
    },

    -- group street props
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


    -- group sacks props
    {
        description = DESC_CAT_SACKS_GROUP,
        modelPath = "objects/props/groups_of_stuff/group_sacks_a.cgf",
    },
    {
        description = DESC_CAT_SACKS_GROUP,
        modelPath = "objects/props/groups_of_stuff/group_sacks_b.cgf",
    },
    {
        description = DESC_CAT_SACKS_GROUP,
        modelPath = "objects/props/groups_of_stuff/group_sacks_c.cgf",
    },
    {
        description = DESC_CAT_SACKS_GROUP,
        modelPath = "objects/props/groups_of_stuff/group_sacks_d.cgf",
    },

    -- group street props
    {
        description = "A pile of hay",
        modelPath = "objects/props/groups_of_stuff/group_hay_pile_a.cgf",
    },
    {
        description = "A pile of hay",
        modelPath = "objects/props/groups_of_stuff/group_hay_pile_b.cgf",
    },
    {
        description = "A pile of hay",
        modelPath = "objects/props/groups_of_stuff/group_hay_pile_c.cgf",
    },
    {
        description = "A pile of hay",
        modelPath = "objects/props/groups_of_stuff/group_hay_pile_d.cgf",
    },


    -- group box groups
    {
        description = DESC_CAT_GROUP_BOXES,
        modelPath = "objects/props/groups_of_stuff/group_box_a.cgf",
    },
    {
        description = DESC_CAT_GROUP_BOXES,
        modelPath = "objects/props/groups_of_stuff/group_box_b.cgf",
    },
    {
        description = DESC_CAT_GROUP_BOXES,
        modelPath = "objects/props/groups_of_stuff/group_box_c.cgf",
    },
    {
        description = DESC_CAT_GROUP_BOXES,
        modelPath = "objects/props/groups_of_stuff/group_box_d.cgf",
    },

    -- group - shelves
    {
        description = DESC_CAT_GROUP_SHELVES,
        modelPath = "objects/props/groups_of_stuff/group_shelve_a.cgf",
    },
    {
        description = DESC_CAT_GROUP_SHELVES,
        modelPath = "objects/props/groups_of_stuff/group_shelve_b.cgf",
    },
    {
        description = DESC_CAT_GROUP_SHELVES,
        modelPath = "objects/props/groups_of_stuff/group_shelve_c.cgf",
    },

    -- group - barrels
    {
        description = DESC_CAT_GROUP_BARRELS,
        modelPath = "objects/props/groups_of_stuff/group_barrels_a.cgf",
    },
    {
        description = DESC_CAT_GROUP_BARRELS,
        modelPath = "objects/props/groups_of_stuff/group_barrels_b.cgf",
    },
    {
        description = DESC_CAT_GROUP_BARRELS,
        modelPath = "objects/props/groups_of_stuff/group_barrels_c.cgf",
    },
    {
        description = DESC_CAT_GROUP_BARRELS,
        modelPath = "objects/props/groups_of_stuff/group_barrels_d.cgf",
    },


    -- decorative

    -- props - things which are used in a tavern
    {
        description = "A barrel filled with delicious beer.",
        modelPath = "objects/props/tavern_things/beer_barrel.cgf",
        saveable = true,
        generator = false, generatorOnUse = true,
        generatorItem = "beer", generatorItemAmount = 1, generatorCapacity = 20,
        generatorCooldown = 5, generatorItemCosts = { groschen = 10 },
    },
    { modelPath = "objects/props/tavern_things/bowl_clear.cgf", },
    { modelPath = "objects/props/tavern_things/wood_tankard.cgf", },
    { modelPath = "objects/props/tavern_things/wood_tankard_full.cgf", },
    { modelPath = "objects/props/tavern_things/wooden_stein.cgf", },


    -- props - target for bow & arrow training
    {
        modelPath = "objects/props/target/target.cgf",
        description = "A target made out of different rings of straw.",
        reactsToCollision = true
    },

    {
        description = "A stand for targets made out of wood",
        modelPath = "objects/props/target/target_stand.cgf",
    },


    -- decorative - candles
    {
        description = "A small candle.",
        modelPath = "objects/props/interiors/candlesticks/candle_01.cgf",
        generatorItemCosts = { groschen = 25 }
    },

    {
        description = "A large candle.",
        modelPath = "objects/props/interiors/candlesticks/candle_02.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "A group of candles.",
        modelPath = "objects/props/interiors/candlesticks/candles_group_01.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "Another group of candles.",
        modelPath = "objects/props/interiors/candlesticks/candles_group_02.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "Another group of candles.",
        modelPath = "objects/props/interiors/candlesticks/candlestick01.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "Another group of candles.",
        modelPath = "objects/props/interiors/candlesticks/candlestick02.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "Another group of candles.",
        modelPath = "objects/props/interiors/candlesticks/candlestick03.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "A beautiful chandelier.",
        modelPath = "objects/props/interiors/candlesticks/chandelier_01.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    -- decorative -- ovens
    {
        description = "A fireplace made out of stone.",
        modelPath = "objects/props/interiors/fireplaces/fireplace_04.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    -- decorative -- kitchenware
    {
        description = "A plate made out of metal.",
        modelPath = "objects/props/interiors/kitchenware/plates/plate_01/plate_01.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    --[[
    {
        description = "A fork made out of metal.",
        modelPath = "objects/props/interiors/kitchenware/eating_tools/knife_eating/fork_eating.cgf",
        generatorItemCosts = { groschen = 50 }
    },
    {
        description = "A knife made out of metal.",
        modelPath = "objects/props/interiors/kitchenware/eating_tools/knife_eating/knife_eating.cgf",
        generatorItemCosts = { groschen = 50 }
    },
    ]]--

    {
        description = "A spoon made out of metal.",
        modelPath = "objects/props/interiors/kitchenware/eating_tools/spoons/metal_spoon.cgf",
        generatorItemCosts = { groschen = 50 }
    },


    {
        description = "A bowl made out of copper.",
        modelPath = "objects/props/interiors/kitchenware/bowls/bowl_copper_1.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "A wodden scuttle.",
        modelPath = "objects/props/interiors/kitchenware/scuttle/scuttle_seeding_02.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "A jug made out of burned clay.",
        modelPath = "objects/props/interiors/kitchenware/jugs/jug_01/jug_01.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "A kettle made out of metal.",
        modelPath = "objects/props/interiors/kitchenware/kettles/kettle02.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "Another jug made out of burned clay.",
        modelPath = "objects/props/interiors/kitchenware/jugs/jug_milk/jug_milk.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "A teapod made out of metal.",
        modelPath = "objects/props/interiors/kitchenware/eating_tools/teapod/teapod_metal.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    -- decorative - office
    {
        description = "The alchemy book.",
        modelPath = "objects/props/alchemy/book/alchemy_book.cgf",
        generatorItemCosts = { groschen = 50 }
    },
    {
        description = "The alchemy book, but closed.",
        modelPath = "objects/props/alchemy/book/alchemy_book_closed.cgf",
        generatorItemCosts = { groschen = 50 }
    },
    {
        description = "A beautiful book",
        modelPath = "objects/props/alchemy/book/book_01.cgf",
        generatorItemCosts = { groschen = 50 }
    },
    {
        description = "Another beautiful book",
        modelPath = "objects/props/alchemy/book/book_02.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "A beautiful bookstand",
        modelPath = "objects/props/alchemy/bookstand/bookstand.cgf",
        generatorItemCosts = { groschen = 50 }
    },
    {
        description = "A beautiful bookstand but small.",
        modelPath = "objects/props/alchemy/bookstand/bookstand_table.cgf",
        generatorItemCosts = { groschen = 50 }
    },

    {
        description = "A bookshelf.",
        modelPath = "objects/props/furniture/bookshelf/library_bookshelf_group_a_1.cgf",
        generatorItemCosts = { groschen = 1000 }
    },
    {
        description = "A bookshelf.",
        modelPath = "objects/props/furniture/bookshelf/library_bookshelf_group_a_2.cgf",
        generatorItemCosts = { groschen = 1000 }
    },
    {
        description = "A bookshelf.",
        modelPath = "objects/props/furniture/bookshelf/library_bookshelf_group_a_3.cgf",
        generatorItemCosts = { groschen = 1000 }
    },
    {
        description = "A bookshelf.",
        modelPath = "objects/props/furniture/bookshelf/library_bookshelf_group_b_1.cgf",
        generatorItemCosts = { groschen = 1000 }
    },
    {
        description = "A bookshelf.",
        modelPath = "objects/props/furniture/bookshelf/library_bookshelf_group_b_2.cgf",
        generatorItemCosts = { groschen = 1000 }
    },
    {
        description = "A bookshelf.",
        modelPath = "objects/props/furniture/bookshelf/library_bookshelf_group_b_3.cgf",
        generatorItemCosts = { groschen = 1000 }
    },


    -- decorative - icons

    {
        description = "A decorative item.",
        modelPath = "objects/props/misc/icons/icon_a.cgf",
    },
    {
        description = "A decorative item.",
        modelPath = "objects/props/misc/icons/icon_b.cgf",
    },
    {
        description = "A decorative item.",
        modelPath = "objects/props/misc/icons/icon_c.cgf",
    },
    {
        description = "A decorative item.",
        modelPath = "objects/props/misc/icons/icon_d.cgf",
    },
    {
        description = "A decorative item.",
        modelPath = "objects/props/misc/icons/icon_e.cgf",
    },
    {
        description = "A decorative item.",
        modelPath = "objects/props/misc/icons/icon_f.cgf",
    },

    -- props / curbs
    {
        description = "A small wooden curb",
        modelPath = "Objects/vehicles/cart/wooden_curb_01.cgf",
    },
    {
        description = "A small wooden curb",
        modelPath = "Objects/vehicles/cart/wooden_curb_02.cgf",
    },
    {
        description = "A long wooden curb",
        modelPath = "Objects/vehicles/cart/wooden_curb_long_a.cgf",
    },
    {
        description = "A long wooden curb",
        modelPath = "Objects/vehicles/cart/wooden_curb_long_b.cgf",
    },
    {
        description = "A boiler from a brewery.",
        modelPath = "objects/structures/brewery/brewery_boiler_a.cgf",
    },
    {
        description = "A boiler from a brewery.",
        modelPath = "objects/structures/brewery/brewery_boiler_b.cgf",
    },

    -- furniture -- inner furniture and decorations
    {
        description = "A decorative shelve.",
        modelPath = "Objects/props/interiors/home_content/shelve_homeworks.cgf"
    },
    {
        description = "A couple of decorative ceramic elements",
        modelPath = "Objects/props/interiors/home_content/pk_group_ceramics.cgf"
    },

    -- misc
    {
        description = "A wooden plattform.",
        modelPath = "objects/structures/platforms/wooden_riser_b.cgf",

    },

    {
        description = "A wooden beam.",
        modelPath = "Objects/buildings/churches/church_pribyslawitz/pribyslawitz_beam.cgf",
    },

    {
        description = "A cart which can transfer goods from a to b.",
        modelPath = "objects/vehicles/cart/cart_01.cgf",
    },


    -- trailer content
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
    },

    -- misc misc

    {
        description = "A stream of water, great for building rivers.",
        modelPath = "objects/nature/stream_edge/stream_water_v4_a.cgf",
    },


    {
        description = "A scarecrow to scare crows.",
        modelPath = "objects/props/scarecrow/scarecrow.cgf",
    },

}


--[[
    big old lua methods
]]--


-- used to initialize the available constructions
function initializeBuildings()

    bIndex = 1

    for index = 1, #parameterizedConstructions do

        construction = parameterizedConstructions[index]

        -- remove the postfix ending ".cgf" from the name
        -- construction.name = parameterizedConstructions[index].modelPath
        construction.name = string.gsub(parameterizedConstructions[index].modelPath, ".cgf", "")

        -- locate the index of the last /
        lastIndex = string.find(construction.name, "/[^/]*$")

        -- create a substring of from the stripped down modelPath
        parameterizedConstructions[index].name = string.sub(construction.name, lastIndex + 1)
        --parameterizedConstructions[index].name = construction.name

    end

    System.LogAlways("initializeBuildings has been called!")

end
initializeBuildings() -- this needs to get executed while loading so this call is accepted


-- a search method in order to find constructions based on names or their descriptions
-- #search("wood") - logs every available construction to the console
-- #search("gate") - logs every gate related construction to the console
-- #search("")     - logs every construction to the console
function search(searchName)

    firstMatch = -1

    for index = 1, #parameterizedConstructions do

        construction = parameterizedConstructions[index]

        if (construction.name ~= nil) then

            -- if there is an object with the same name as the construction name (both to lower) ...
            if string.find(string.lower(construction.name), string.lower(searchName)) then

                matchId = index

                log("" .. matchId .. ".) " .. construction.name)

                if firstMatch == -1 and searchName ~= "" then
                    firstMatch = index
                end

            else

            end

        end

    end

    return firstMatch

end
