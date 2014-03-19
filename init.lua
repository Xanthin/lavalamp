-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end

local lavalamps_list = {
	{ "Red Lava Lamp", "red"},
	{ "Orange Lava Lamp", "orange"},	
	{ "Yellow Lava Lamp", "yellow"},
	{ "Green Lava Lamp", "green"},
	{ "Blue Lava Lamp", "blue"},
	{ "Violet Lava Lamp", "violet"},
}

for i in ipairs(lavalamps_list) do
	local lavalampdesc = lavalamps_list[i][1]
	local colour = lavalamps_list[i][2]

	minetest.register_node("lavalamp:"..colour, {
	    description = S(lavalampdesc),
	    drawtype = "nodebox",
	    tiles = {
	        "lavalamp_lamp_top.png",
	        "lavalamp_lamp_bottom.png",
	        {
	            name="lavalamp_lamp_anim_"..colour..".png",
	            animation={
	                type="vertical_frames",
	                aspect_w=40,
	                aspect_h=40,
	                length=3.0,
	            },
	        },
	    },    
	    paramtype = "light",
	    paramtype2 = "facedir",
	    node_box = {
	        type = "fixed",
	        fixed = {        
				-- base
	            { -0.1875, -0.5,  -0.1875,  0.1875, -0.3125,  0.1875, },
	            { -0.125, -0.5,  -0.25,  0.125, -0.3125,  -0.1875, },
	            { -0.25, -0.5,  -0.125,  -0.1875, -0.3125,  0.125, },
	            { 0.1875, -0.5,  -0.125,  0.25, -0.3125,  0.125, },
	            { -0.125, -0.5,  0.1875,  0.125, -0.3125,  0.25, },          
	            -- lamp
	            { -0.125, -0.3125,  -0.125,  0.125,  0.5,  0.125, },
	            { -0.0625,  -0.3125,  -0.1875,  0.0625,  0.5,  -0.125, },
	            { -0.0625,  -0.3125,  0.125,  0.0625,  0.5,  0.1875, },	 
	            { -0.1875,  -0.3125,  -0.0625,  0.125,  0.5,  0.0625, },
	            { 0.125,  -0.3125,  -0.0625,  0.1875,  0.5,  0.0625, },	           			
	        },
	    },
	    sunlight_propagates = true,
	    walkable = false,
	    light_source = 14,
	    selection_box = {
	        type = "fixed",
	        fixed = { -0.25, -0.5, -0.25, 0.25,0.5, 0.25 },
	    },
		groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
		on_rightclick = function(pos, node, clicker)
	        node.name = "lavalamp:"..colour.."_off"
	        minetest.env:set_node(pos, node)
	    end,
	})

	minetest.register_node("lavalamp:"..colour.."_off", {
	    description = S(lavalampdesc.." off"),
	    drawtype = "nodebox",
	    tiles = {
	        "lavalamp_lamp_top.png",
	        "lavalamp_lamp_bottom.png",
	        "lavalamp_lamp_off_sides.png",
	    },	    
	    paramtype = "light",
	    paramtype2 = "facedir",
	    node_box = {
	        type = "fixed",
			fixed = {        
				-- base
	            { -0.1875, -0.5,  -0.1875,  0.1875, -0.3125,  0.1875, },
	            { -0.125, -0.5,  -0.25,  0.125, -0.3125,  -0.1875, },
	            { -0.25, -0.5,  -0.125,  -0.1875, -0.3125,  0.125, },
	            { 0.1875, -0.5,  -0.125,  0.25, -0.3125,  0.125, },
	            { -0.125, -0.5,  0.1875,  0.125, -0.3125,  0.25, },          
	            -- lamp
	            { -0.125, -0.3125,  -0.125,  0.125,  0.5,  0.125, },
	            { -0.0625,  -0.3125,  -0.1875,  0.0625,  0.5,  -0.125, },
	            { -0.0625,  -0.3125,  0.125,  0.0625,  0.5,  0.1875, },	 
	            { -0.1875,  -0.3125,  -0.0625,  0.125,  0.5,  0.0625, },
	            { 0.125,  -0.3125,  -0.0625,  0.1875,  0.5,  0.0625, },	           			
	        },
	    },
	    sunlight_propagates = true,
	    walkable = false,
	    selection_box = {
	        type = "fixed",
	        fixed = { -0.25, -0.5, -0.25, 0.25,0.5, 0.25 },
	    },
		groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	    drop = "lavalamp:"..colour,
		on_rightclick = function(pos, node, clicker)
	        node.name = "lavalamp:"..colour
	        minetest.env:set_node(pos, node)
	    end,
	})

	minetest.register_craft({
		output = "lavalamp:"..colour,
		recipe = {
			{"", "wool:"..colour, "", },
			{"", "bucket:bucket_water", "", },
			{"", "wool:black", "", }
		}
	})
	
end





