/datum/configuration_section/mapping
	name = "mapping"

	var/preferable_engine
	var/preferable_biodome
	var/preferable_bar_frontier
	var/preferable_bar_exodus
	var/derelicts_amount
	var/list/allowed_maps

/datum/configuration_section/mapping/load_data(list/data)

	CONFIG_LOAD_STR(preferable_engine,  data["preferable_engine"])
	CONFIG_LOAD_STR(preferable_biodome, data["preferable_biodome"])
	CONFIG_LOAD_STR(preferable_bar_frontier, 	data["preferable_bar_frontier"])
	CONFIG_LOAD_STR(preferable_bar_exodus, 		data["preferable_bar_exodus"])
	CONFIG_LOAD_NUM(derelicts_amount,	data["derelicts_amount"])
	CONFIG_LOAD_LIST(allowed_maps, 		data["allowed_maps"])

	if(!(preferable_engine in list(MAP_ENG_RANDOM, MAP_ENG_SINGULARITY, MAP_ENG_MATTER)))
		preferable_engine = MAP_ENG_SINGULARITY
	if(!(preferable_biodome in list(MAP_BIO_RANDOM, MAP_BIO_FOREST, MAP_BIO_WINTER, MAP_BIO_BEACH, MAP_BIO_CONCERT)))
		preferable_biodome = MAP_BIO_FOREST
	if(!(preferable_bar_exodus in list(MAP_BAR_RANDOM, MAP_BAR_CLASSIC, MAP_BAR_MED, MAP_BAR_HOLO, MAP_BAR_LEFT, MAP_BAR_SIEGE, MAP_BAR_SKY, MAP_BAR_STEEL, MAP_BAR_TWOFL)))
		preferable_bar_exodus = MAP_BAR_CLASSIC
	if(!(preferable_bar_frontier in list(MAP_BAR_RANDOM, MAP_BAR_CLASSIC, MAP_BAR_MODERN, MAP_BAR_SALOON)))
		preferable_bar_frontier = MAP_BAR_CLASSIC
