/datum/map_template/holodeck
	returns_created_atoms = TRUE
	/// Internal template identifier, might be or might not be a file name, used generally by UI.
	var/template_id
	/// Whether the template can be unlocked by emagging a console.
	var/restricted = FALSE
	/// List of SFX tags to be played when template is loaded.
	var/list/ambience
	/// List of SFX tags to be played as ambience music when template is loaded.
	var/list/ambience_music

	var/holodeck_area = /area/holodeck

/datum/map_template/holodeck/update_blacklist(turf/source_turf, centered, list/turf_blacklist)
	for(var/turf/affecting_turf as anything in get_affected_turfs(source_turf, centered))
		if(affecting_turf.holodeck_compatible || (affecting_turf.atom_flags & ATOM_FLAG_HOLOGRAM))
			continue

		turf_blacklist[affecting_turf] = TRUE

/datum/map_template/holodeck/basketball
	name = "basketball field"
	template_id = "holodeck_basketball"
	mappaths = list("maps/templates/holodeck/holodeck_basketball.dmm")
	ambience_music = list(SFX_AMBIENT_MUSIC_THUNDERDOME)

/datum/map_template/holodeck/beach
	name = "sunny beach"
	template_id = "holodeck_beach"
	mappaths = list("maps/templates/holodeck/holodeck_beach.dmm")

/datum/map_template/holodeck/boxing
	name = "boxing arena"
	template_id = "holodeck_boxing"
	mappaths = list("maps/templates/holodeck/holodeck_boxing.dmm")
	ambience_music = list(SFX_AMBIENT_MUSIC_THUNDERDOME)

/datum/map_template/holodeck/chess
	name = "space chess"
	template_id = "holodeck_chess"
	mappaths = list("maps/templates/holodeck/holodeck_chess.dmm")

/datum/map_template/holodeck/courtroom
	name = "courtroom"
	template_id = "holodeck_courtroom"
	mappaths = list("maps/templates/holodeck/holodeck_courtroom.dmm")
	ambience_music = list(SFX_AMBIENT_MUSIC_COURT)

/datum/map_template/holodeck/desert
	name = "space desert"
	template_id = "holodeck_desert"
	mappaths = list("maps/templates/holodeck/holodeck_desert.dmm")
	ambience = list(SFX_AMBIENT_DESERT)

/datum/map_template/holodeck/disco
	name = "disco room"
	template_id = "holodeck_disco"
	mappaths = list("maps/templates/holodeck/holodeck_disco.dmm")

/datum/map_template/holodeck/lasertag
	name = "lasertag arena"
	template_id = "holodeck_lasertag"
	mappaths = list("maps/templates/holodeck/holodeck_lasertag.dmm")
	ambience_music = list(SFX_AMBIENT_MUSIC_THUNDERDOME)

/datum/map_template/holodeck/meetingroom
	name = "meeting room"
	template_id = "holodeck_meetingroom"
	mappaths = list("maps/templates/holodeck/holodeck_meetingroom.dmm")

/datum/map_template/holodeck/offline
	name = "offline"
	template_id = "holodeck_offline"
	mappaths = list("maps/templates/holodeck/holodeck_offline.dmm")

/datum/map_template/holodeck/picnic
	name = "mediterranean picnic"
	template_id = "holodeck_picnic"
	mappaths = list("maps/templates/holodeck/holodeck_picnic.dmm")
	ambience_music = list(SFX_AMBIENT_MUSIC_PICNIC)

/datum/map_template/holodeck/snow
	name = "snow desert"
	template_id = "holodeck_snow"
	mappaths = list("maps/templates/holodeck/holodeck_snow.dmm")
	ambience = list(SFX_AMBIENT_DESERT)

/datum/map_template/holodeck/space
	name = "totally accurate space"
	template_id = "holodeck_space"
	mappaths = list("maps/templates/holodeck/holodeck_space.dmm")
	ambience = list(SFX_AMBIENT_SPACE)

/datum/map_template/holodeck/theatre
	name = "space theatre"
	template_id = "holodeck_theatre"
	mappaths = list("maps/templates/holodeck/holodeck_theatre.dmm")

/datum/map_template/holodeck/thunderdome
	name = "thunderdome arena"
	template_id = "holodeck_thunderdome"
	mappaths = list("maps/templates/holodeck/holodeck_thunderdome.dmm")
	ambience_music = list(SFX_AMBIENT_MUSIC_THUNDERDOME)

/datum/map_template/holodeck/wildlife
	name = "wildlife simulation"
	template_id = "holodeck_wildlife"
	mappaths = list("maps/templates/holodeck/holodeck_wildlife.dmm")
	restricted = TRUE

/datum/map_template/holodeck/beach/bar
	mappaths = list("maps/templates/holodeck/bar/holodeck_beach.dmm")
	template_id = "holodeck_beach_bar"
	holodeck_area = /area/holodeck/bar

/datum/map_template/holodeck/desert/bar
	mappaths = list("maps/templates/holodeck/bar/holodeck_desert.dmm")
	template_id = "holodeck_desert_bar"
	holodeck_area = /area/holodeck/bar

/datum/map_template/holodeck/disco/bar
	mappaths = list("maps/templates/holodeck/bar/holodeck_disco.dmm")
	template_id = "holodeck_disco_bar"
	holodeck_area = /area/holodeck/bar

/datum/map_template/holodeck/offline/bar
	mappaths = list("maps/templates/holodeck/bar/holodeck_offline.dmm")
	template_id = "holodeck_offline_bar"
	holodeck_area = /area/holodeck/bar

/datum/map_template/holodeck/picnic/bar
	mappaths = list("maps/templates/holodeck/bar/holodeck_picnic.dmm")
	template_id = "holodeck_picnic_bar"
	holodeck_area = /area/holodeck/bar

/datum/map_template/holodeck/snow/bar
	mappaths = list("maps/templates/holodeck/bar/holodeck_snow.dmm")
	template_id = "holodeck_snow_bar"
	holodeck_area = /area/holodeck/bar

/datum/map_template/holodeck/space/bar
	mappaths = list("maps/templates/holodeck/bar/holodeck_space.dmm")
	template_id = "holodeck_space_bar"
	holodeck_area = /area/holodeck/bar

/datum/map_template/holodeck/wildlife/bar
	mappaths = list("maps/templates/holodeck/bar/holodeck_wildlife.dmm")
	template_id = "holodeck_wildlife_bar"
	holodeck_area = /area/holodeck/bar
