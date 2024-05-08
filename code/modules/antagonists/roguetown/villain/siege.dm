/datum/antagonist/siege
    name = "Siege"
    roundend_category = "siege"
    antagpanel_category = "Siege"
    job_rank = ROLE_SIEGE
    antag_hud_type = ANTAG_HUD_TRAITOR
    antag_hud_name = "baron's men"
    var/is_baron = FALSE
    confess_lines = list("FOR THE BARON!!", "I WILL NOT SERVE THE KING!", "I WILL NOT FOLLOW YOUR LAWS!")

    var/global/list/baron_spawned = list()
    var/global/list/soldier_starts = list()

/datum/antagonist/siege/on_gain()
    if(!length(baron_spawned))
        baron_spawned += TRUE
        is_baron = TRUE
        equip_baron()
    else
        equip_soldier()

/datum/antagonist/siege/on_gain()
    owner.special_role = "Siege"
    owner.assigned_role = "Siege"
    if(owner.current)
        owner.current.job = null
    forge_objectives()
    finalize_siege()
    move_to_spawnpoint()
    if(owner.current && length(soldier_starts))
        owner.current.forceMove(pick(soldier_starts))

/datum/antagonist/siege/proc/forge_objectives()
    if(is_baron)
        // Placeholder: Replace this with the code to assign the baron's objectives
        if(owner.current)
            to_chat(owner.current, "<span class='boldnotice'>Baron Objectives Placeholder</span>")
    else
        // Existing code to assign soldier's objectives
        // ... (existing objective assignment code)

/datum/antagonist/siege/proc/finalize_siege()
    if(owner.current)
        owner.current.playsound_local(get_turf(owner.current), 'sound/music/traitor.ogg', 80, FALSE, pressure_affected = FALSE)
        var/mob/living/carbon/human/H = owner.current
        ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
        ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/antagonist/siege/proc/move_to_spawnpoint()
    if(owner.current && length(GLOB.bandit_starts))
        owner.current.forceMove(pick(GLOB.bandit_starts))

    if(owner.current && length(soldier_starts))
        owner.current.forceMove(pick(soldier_starts))

/datum/antagonist/siege/proc/equip_baron()
    if(owner.current)
        to_chat(owner.current, "<span class='boldnotice'>You are the Baron!</span>")

/datum/antagonist/siege/proc/equip_soldier()
    if(owner.current)
        to_chat(owner.current, "<span class='boldnotice'>You are one of the barons men!</span>")

/datum/outfit/job/roguetown/baron/pre_equip(mob/living/carbon/human/H)
	..()

	gloves = /obj/item/clothing/gloves/roguetown/plate
	pants = /obj/item/clothing/under/roguetown/platelegs
	cloak = /obj/item/clothing/cloak/tabard/knight/guard
	neck = /obj/item/clothing/neck/roguetown/gorget
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	beltl = /obj/item/keyring/guardcastle
	belt = /obj/item/storage/belt/rogue/leather/hand
	backr = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		backl = /obj/item/rogueweapon/sword/long
		H.change_stat("strength", 4)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

	ADD_TRAIT(H, RTRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/outfit/job/roguetown/soldier/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet
	pants = /obj/item/clothing/under/roguetown/chainlegs
	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	gloves = /obj/item/clothing/gloves/roguetown/chain
	shoes = /obj/item/clothing/shoes/roguetown/boots
	beltl = /obj/item/keyring/guardcastle
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/sword
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rope/chain = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, pick(3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(4,4,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, pick(3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
	if(H.gender == FEMALE)
		var/acceptable = list("Tomboy", "Bob", "Curly Short")
		if(!(H.hairstyle in acceptable))
			H.hairstyle = pick(acceptable)
			H.update_hair()
	ADD_TRAIT(H, RTRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, RTRAIT_MEDIUMARMOR, TRAIT_GENERIC)