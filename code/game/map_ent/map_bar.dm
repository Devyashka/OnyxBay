/obj/map_ent/util_bar
	name = "util_bar"
	icon_state = "util_bar"

	var/ev_bar
	var/ev_result

/obj/map_ent/util_bar/activate()
	var/target_bar = ev_bar

	if(!target_bar)
		target_bar = config.mapping.preferable_bar_frontier

	if(target_bar == MAP_BAR_RANDOM)
		target_bar = pick(MAP_BAR_CLASSIC, MAP_BAR_MODERN, MAP_BAR_SALOON)

	ev_result = "maps/[GLOB.using_map.path]/bar/[target_bar].dmm"

/obj/map_ent/util_bar/exodus
	name = "util_bar_exodus"
	var/z_level = 2

/obj/map_ent/util_bar/exodus/activate()
	var/target_bar = MAP_BAR_HOLO

	if(!target_bar)
		if(GLOB.using_map.template_maps[name])
			target_bar = GLOB.using_map.template_maps[name]
		else
			target_bar = config.mapping.preferable_bar_exodus
			GLOB.using_map.template_maps[name] = target_bar

	if(target_bar == MAP_BAR_RANDOM)
		target_bar = pick(MAP_BAR_CLASSIC, MAP_BAR_MED, MAP_BAR_HOLO, MAP_BAR_LEFT, MAP_BAR_SIEGE, MAP_BAR_SKY, MAP_BAR_STEEL, MAP_BAR_TWOFL)
		GLOB.using_map.template_maps[name] = target_bar
	ev_result = generate_path(target_bar)

/obj/map_ent/util_bar/exodus/proc/generate_path(target_bar)
	var/tfile = "maps/[GLOB.using_map.path]/bar/[target_bar]-[z_level].dmm"
	if(MAP_BAR_CLASSIC != target_bar && !fexists(tfile))
		return generate_path(MAP_BAR_CLASSIC)
	return tfile
