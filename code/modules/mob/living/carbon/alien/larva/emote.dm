/mob/living/carbon/alien/larva/emote(var/act,var/m_type=1,var/message = null)

	var/param = null
	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)
	var/muzzled = istype(src.wear_mask, /obj/item/clothing/mask/muzzle)

	switch(act)
		if("sign")
			if (!src.restrained())
				message = text("<B>The alien</B> signs[].", (text2num(param) ? text(" the number []", text2num(param)) : null))
				m_type = 1
		if ("burp")
			if (!muzzled)
				message = "<B>[src]</B> burps."
				m_type = 2
		if("scratch")
			if (!src.restrained())
				message = "<B>The [src.name]</B> scratches."
				m_type = 1
		if("whimper")
			if (!muzzled)
				message = "<B>The [src.name]</B> whimpers."
				m_type = 2
//		if("roar")
//			if (!muzzled)
//				message = "<B>The [src.name]</B> roars." Commenting out since larva shouldn't roar /N
//				m_type = 2
		if("tail")
			message = "<B>The [src.name]</B> waves its tail."
			m_type = 1
		if("gasp")
			message = "<B>The [src.name]</B> gasps."
			m_type = 2
		if("shiver")
			message = "<B>The [src.name]</B> shivers."
			m_type = 2
		if("drool")
			message = "<B>The [src.name]</B> drools."
			m_type = 1
		if("scretch")
			if (!muzzled)
				message = "<B>The [src.name]</B> scretches."
				m_type = 2
		if("choke")
			message = "<B>The [src.name]</B> chokes."
			m_type = 2
		if("moan")
			message = "<B>The [src.name]</B> moans!"
			m_type = 2
		if("nod")
			message = "<B>The [src.name]</B> nods its head."
			m_type = 1
//		if("sit")
//			message = "<B>The [src.name]</B> sits down." //Larvan can't sit down, /N
//			m_type = 1
		if("sway")
			message = "<B>The [src.name]</B> sways around dizzily."
			m_type = 1
		if("sulk")
			message = "<B>The [src.name]</B> sulks down sadly."
			m_type = 1
		if("twitch")
			message = "<B>The [src.name]</B> twitches violently."
			m_type = 1
		if("dance")
			if (!src.restrained())
				message = "<B>The [src.name]</B> dances around happily."
				m_type = 1
		if("roll")
			if (!src.restrained())
				message = "<B>The [src.name]</B> rolls."
				m_type = 1
		if("shake")
			message = "<B>The [src.name]</B> shakes its head."
			m_type = 1
		if("gnarl")
			if (!muzzled)
				message = "<B>The [src.name]</B> gnarls and shows its teeth.."
				m_type = 2
		if("jump")
			message = "<B>The [src.name]</B> jumps!"
			m_type = 1
		if("collapse")
			Paralyse(2)
			message = text("<B>[]</B> collapses!", src)
			m_type = 2
		if ("me")
			if(silent)
				return
			if (src.client && (client.muted || client.muted_complete))
				src << "You are muted."
				return
			if (stat)
				return
			if(!(message))
				return
			else
				if(cmptext(copytext(message, 1, 3), "v "))
					message = "<B>[src]</B> [copytext(message, 3)]"
					m_type = 1
				else if(cmptext(copytext(message, 1, 3), "h "))
					message = "<B>[src]</B> [copytext(message, 3)]"
					m_type = 2
				else
					message = "<B>[src]</B> [message]"
		if("help")
			src << "burp, choke, collapse, dance, drool, gasp, shiver, gnarl, jump, moan, nod, roll, scratch,\nscretch, shake, sign-#, sulk, sway, tail, twitch, whimper"
		else
			src << text("Invalid Emote: []", act)
	if ((message && src.stat == 0))
		if (m_type & 1)
			for(var/mob/O in viewers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(703)
		else
			for(var/mob/O in hearers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(746)
	return