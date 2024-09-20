/obj/item/gun/projectile/shotgun/pump
	name = "shotgun"
	desc = "The mass-produced W-T Remmington 29x shotgun is a favourite of police and security forces on many worlds. Useful for sweeping alleys."
	icon_state = "shotgun"
	item_state = "shotgun"
	wielded_item_state = "shotgun-wielded"
	max_shells = 4
	w_class = ITEM_SIZE_HUGE
	force = 12.5
	mod_weight = 1.0
	mod_reach = 0.8
	mod_handy = 1.0
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BACK
	caliber = "12g"
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 2)
	load_method = SINGLE_CASING
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	handle_casings = HOLD_CASINGS
	one_hand_penalty = 2
	var/recentpump = 0 // to prevent spammage
	fire_sound = 'sound/effects/weapons/gun/fire_shotgun2.ogg'

/obj/item/gun/projectile/shotgun/pump/consume_next_projectile()
	if(chambered)
		return chambered.expend()
	return null

/obj/item/gun/projectile/shotgun/pump/attack_self(mob/living/user as mob)
	if(world.time > recentpump + 10)
		recentpump = world.time
		pump(user)

/obj/item/gun/projectile/shotgun/pump/proc/pump(atom/movable/user)
	playsound(user, SFX_SHOTGUN_PUMP_IN, rand(45, 60), FALSE)

	if(chambered)//We have a shell in the chamber
		ejectCasing()
		chambered = null

	sleep(5)
	playsound(user, SFX_SHOTGUN_PUMP_OUT, rand(45, 60), FALSE)

	if(loaded.len)
		var/obj/item/ammo_casing/AC = loaded[1] //load next casing.
		loaded -= AC //Remove casing from loaded list.
		chambered = AC

	update_icon()

/obj/item/gun/projectile/shotgun/pump/combat
	name = "combat shotgun"
	desc = "Built for close quarters combat, the Hephaestus Industries KS-40 is widely regarded as a weapon of choice for repelling boarders."
	icon_state = "cshotgun"
	item_state = "cshotgun"
	wielded_item_state = "cshotgun-wielded"
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2)
	max_shells = 7 //match the ammo box capacity, also it can hold a round in the chamber anyways, for a total of 8.
	ammo_type = /obj/item/ammo_casing/shotgun
	one_hand_penalty = 3 //a little heavier than the regular shotgun

/obj/item/gun/projectile/shotgun/pump/combat/hos
	name = "KS-40"
	desc = "Built for close quarters combat, the Hephaestus Industries KS-40 is widely regarded as a weapon of choice for repelling boarders. This one emmits LAW."
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/gun/projectile/shotgun/pump/compact
	name = "compact shotgun"
	desc = "The GA Protector: Compact, gripping, and decisively powerful weapon for face-to-face combat."
	icon_state = "compact-shotgun"
	item_state = "compact-shotgun"
	wielded_item_state = "compact-shotgun-wielded"
	slot_flags = SLOT_BELT|SLOT_BACK
	w_class = ITEM_SIZE_NORMAL
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 2) //more stylish than a combat shotgun
	max_shells = 3
	force = 9.5
	mod_weight = 0.85
	mod_reach = 0.8
	mod_handy = 0.9
	ammo_type = /obj/item/ammo_casing/shotgun
	one_hand_penalty = 1

/obj/item/gun/projectile/shotgun/pump/boomstick
	name = "makeshift shotgun"
	icon_state = "boomstick"
	item_state = "boomstick"
	wielded_item_state = "boomstick-wielded"
	desc = "It's better to use this thing rather than throw shotgun shells at people. Probably."
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 1)
	slot_flags = null
	max_shells = 1
	mod_weight = 1.0
	mod_reach = 0.75
	mod_handy = 0.75
	has_safety = FALSE

// Zip gun construction.
/obj/item/boomstickframe
	name = "modified welding tool"
	desc = "A half-finished... gun?"
	icon = 'icons/obj/guns/gun.dmi'
	icon_state = "boomstick0"
	item_state = "welder"
	force = 5.0
	throwforce = 5.0
	throw_range = 5
	w_class = ITEM_SIZE_HUGE
	mod_weight = 1.0
	mod_reach = 0.75
	mod_handy = 0.75
	var/buildstate = 0

/obj/item/boomstickframe/on_update_icon()
	icon_state = "boomstick[buildstate]"

/obj/item/boomstickframe/examine(mob/user, infix)
	. = ..()

	switch(buildstate)
		if(0) . += "It has a pipe loosely fitted to the welding tool."
		if(1) . += "It has a pipe welded to the welding tool."
		if(2) . += "It has a bent metal rod attached to it."
		if(3) . += "It has a spring inside."
		if(4) . += "It is all covered with duct tape."

/obj/item/boomstickframe/attackby(obj/item/W, mob/user)
	if(isWelder(W) && buildstate == 0)
		var/obj/item/weldingtool/WT = W
		if(!WT.use_tool(src, user, amount = 1))
			return

		user.visible_message("<span class='notice'>\The [user] secures \the [src]'s barrel.</span>")
		add_fingerprint(user)
		buildstate++
		update_icon()
		return
	else if(istype(W,/obj/item/stack/rods) && buildstate == 1)
		var/obj/item/stack/rods/R = W
		R.use(1)
		user.visible_message("<span class='notice'>\The [user] attaches a grip to \the [src].</span>")
		add_fingerprint(user)
		buildstate++
		update_icon()
		return
	else if(istype(W,/obj/item/device/assembly/mousetrap) && buildstate == 2)
		qdel(W)
		user.visible_message("<span class='notice'>\The [user] takes apart \the [W] and uses the parts to construct a crude chamber loader inside \the [src].</span>")
		add_fingerprint(user)
		buildstate++
		update_icon()
		return
	else if(istype(W,/obj/item/tape_roll) && buildstate == 3)
		user.visible_message("<span class='notice'>\The [user] madly wraps the assembly with \the [W].</span>")
		add_fingerprint(user)
		buildstate++
		update_icon()
		return
	else if(isScrewdriver(W) && buildstate == 4)
		user.visible_message("<span class='notice'>\The [user] secures \the [src] with \the [W].</span>")
		playsound(loc, 'sound/items/Screwdriver.ogg', 50, 1)
		var/obj/item/gun/projectile/shotgun/pump/boomstick/herewego
		herewego = new /obj/item/gun/projectile/shotgun/pump/boomstick { starts_loaded = 0 } (loc)
		transfer_fingerprints_to(herewego)
		if(ismob(loc))
			var/mob/M = loc
			M.replace_item(src, herewego, TRUE)
		else
			qdel(src)
		return
	else
		..()

// Double-barreled shotgun
/obj/item/gun/projectile/shotgun/doublebarrel
	name = "double-barreled shotgun"
	desc = "A true classic."
	icon_state = "dshotgun"
	item_state = "dshotgun"
	wielded_item_state = "dshotgun-wielded"
	//SPEEDLOADER because rapid unloading.
	//In principle someone could make a speedloader for it, so it makes sense.
	load_method = SINGLE_CASING|SPEEDLOADER
	handle_casings = CYCLE_CASINGS
	max_shells = 2
	w_class = ITEM_SIZE_HUGE
	force = 12.5
	mod_weight = 1.0
	mod_reach = 0.8
	mod_handy = 1.0
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BACK
	caliber = "12g"
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 1)
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	one_hand_penalty = 2

	burst_delay = 0
	firemodes = list(
		list(mode_name="fire one barrel at a time", burst=1),
		list(mode_name="fire both barrels at once", burst=2),
		)

	fire_sound = 'sound/effects/weapons/gun/fire_shotgun2.ogg'

/obj/item/gun/projectile/shotgun/doublebarrel/pellet
	ammo_type = /obj/item/ammo_casing/shotgun/pellet

/obj/item/gun/projectile/shotgun/doublebarrel/flare
	name = "signal shotgun"
	desc = "A double-barreled shotgun meant to fire signal flash shells."
	ammo_type = /obj/item/ammo_casing/shotgun/flash

/obj/item/gun/projectile/shotgun/doublebarrel/unload_ammo(user, allow_dump)
	..(user, allow_dump=1)

//this is largely hacky and bad :(	-Pete
/obj/item/gun/projectile/shotgun/doublebarrel/attackby(obj/item/A as obj, mob/user as mob)
	if(w_class > 3 && (istype(A, /obj/item/circular_saw) || istype(A, /obj/item/melee/energy) || istype(A, /obj/item/gun/energy/plasmacutter)))
		to_chat(user, "<span class='notice'>You begin to shorten the barrel of \the [src].</span>")
		if(loaded.len)
			for(var/i in 1 to max_shells)
				Fire(user, user)	//will this work? //it will. we call it twice, for twice the FUN
			user.visible_message("<span class='danger'>The shotgun goes off!</span>", "<span class='danger'>The shotgun goes off in your face!</span>")
			return
		if(do_after(user, 30, src, luck_check_type = LUCK_CHECK_COMBAT))	//SHIT IS STEALTHY EYYYYY
			icon_state = "sawnshotgun"
			item_state = "sawnshotgun"
			wielded_item_state = null
			w_class = ITEM_SIZE_NORMAL
			force = 8.5
			mod_weight = 0.7
			mod_reach = 0.7
			mod_handy = 0.85
			one_hand_penalty = 0
			slot_flags &= ~SLOT_BACK	//you can't sling it on your back
			slot_flags |= (SLOT_BELT|SLOT_HOLSTER) //but you can wear it on your belt (poorly concealed under a trenchcoat, ideally) - or in a holster, why not.
			SetName("sawn-off shotgun")
			desc = "Omar's coming!"
			fire_sound = 'sound/effects/weapons/gun/fire_shotgun3.ogg'
			to_chat(user, "<span class='warning'>You shorten the barrel of \the [src]!</span>")
	else
		..()

/obj/item/gun/projectile/shotgun/doublebarrel/sawn
	name = "sawn-off shotgun"
	desc = "Omar's coming!"
	icon_state = "sawnshotgun"
	item_state = "sawnshotgun"
	wielded_item_state = null // It's basically a 12 Cal pistol
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	ammo_type = /obj/item/ammo_casing/shotgun/pellet
	w_class = ITEM_SIZE_NORMAL
	force = 8.5
	mod_weight = 0.7
	mod_reach = 0.7
	mod_handy = 0.85
	one_hand_penalty = 0
	fire_sound = 'sound/effects/weapons/gun/fire_shotgun3.ogg'
