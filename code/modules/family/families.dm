/datum/family/
	var/name
	var/list/members = list()
	var/mob/living/carbon/human/family_head
	var/mob/living/carbon/human/spouse



/datum/family/New(var/mob/living/carbon/human/head)
	var/regex/R = regex("(^\\S+) (.*$)") //Get all words (\w+) that have an end of line ($).  Should pick off last names
	R.Find(head.real_name)
	try
		name = R.group[2]
	catch(var/exception/e)  //If for some reason they fail our regex
		log_debug("Someone's name broke the family regex: [e]")
		name = capitalize(pick(GLOB.last_names))
	family_head = head

// Handles adding someone to the family datum "members"
// Also handles setting the player name correctly
/datum/family/proc/add_member(var/mob/living/carbon/human/member)
	var/regex/R = regex("(^\\S+) (.*$)") //Get first name and last name
	R.Find(member.real_name)
	var/first_name = R.group[1]
	//var/last_name = R.group[2]
	//to_world("Setting real name of: [member.real_name]")
	member.real_name = "[first_name] [name]"
	//to_world("Setting real name is now: [member.real_name]")
	setup_relations(member)
	members |= member

//Where we create and link relations
/datum/family/proc/link_relatives(var/mob/living/carbon/human/owner, var/mob/living/carbon/human/target)
	if(owner == target) //Don't link the same person
		return
	var/family_type
	//Pick relationship to add between these two people
	family_type = pick_relation(owner,target)
	var/relation_1 = matchmaker.relation_types[family_type]
	var/relation_2 = matchmaker.relation_types[pick_inverse(family_type,owner.gender)]
	var/datum/relation/target_relation = new relation_1
	var/datum/relation/owner_relation = new relation_2
	owner_relation.connected_relation = target_relation
	target_relation.connected_relation = owner_relation
	owner_relation.relation_holder = owner.mind
	target_relation.relation_holder = target.mind


//Setup relations between families
/datum/family/proc/setup_relations(var/mob/living/carbon/human/member)
	//Link head and member
	link_relatives(member,family_head)
	for(var/datum/relation/R in matchmaker.get_relationships(family_head.mind))
		var/mob/living/carbon/human/target = R.connected_relation.relation_holder.current
		link_relatives(member,target)

// Pick the correct relation for the position in the family
// If everything here works, it should spit out the correct relation type, for any two family members
// Given the current state of the family.
/datum/family/proc/pick_relation(var/mob/living/carbon/human/owner, var/mob/living/carbon/human/target)
	var/family_type
	var/gender = owner.gender
	switch(gender)
		if(MALE)
			switch((owner.age - target.age))
				if(-18 to 18) //Same generation
					family_type = "Brother"
				if(-INFINITY to -19) //Target is from the Older generation
					family_type = "Son"
				if(19 to INFINITY)  // Target is from the younger generation
					family_type = "Father"
		if(FEMALE)
			switch((owner.age - target.age))
				if(-18 to 18) //Same generation
					family_type = "Sister"
				if(-INFINITY to -19) //Older generation
					family_type = "Daughter"
				if(19 to INFINITY)
					family_type = "Mother"
	//Handle marriage
	if((family_type == "Brother" || family_type == "Sister") && (isnull(spouse)) && (owner.gender != target.gender))  //If we are the same age but different gender, but don't have a spouse, marry us!
		spouse = target
		switch(owner.gender)
			if(MALE)
				family_type = "Husband"
			if(FEMALE)
				family_type = "Wife"
	//Only heads of house can have children
	if((family_type == "Son" || family_type == "Daughter") && (target != family_head && target != spouse))
		switch(owner.gender)
			if(MALE)
				family_type = "Nephew"
			if(FEMALE)
				family_type = "Niece"
	//Only heads of house can be parents
	if((family_type == "Father" || family_type == "Mother") && (target != family_head && target != spouse))
		switch(owner.gender)
			if(MALE)
				family_type = "Uncle"
			if(FEMALE)
				family_type = "Aunt"

	if(!isnull(family_type))
		return family_type

// Picks the opposite of a relationship.  Son -> father uncle -> nephew etc.
/datum/family/proc/pick_inverse(var/relation_type,var/gender)
	switch(gender)
		if(MALE)
			switch(relation_type)
				if("Mother")   return "Son"
				if("Father")   return "Son"
				if("Son")      return "Father"
				if("Daughter") return "Father"
				if("Sister")   return "Brother"
				if("Brother")  return "Brother"
				if("Uncle")	   return "Nephew"
				if("Aunt")     return "Nephew"
				if("Nephew")   return "Uncle"
				if("Niece")    return "Uncle"
		if(FEMALE)
			switch(relation_type)
				if("Mother")   return "Daughter"
				if("Father")   return "Daughter"
				if("Son")      return "Mother"
				if("Daughter") return "Mother"
				if("Sister")   return "Sister"
				if("Brother")  return "Sister"
				if("Uncle")	   return "Niece"
				if("Aunt")     return "Niece"
				if("Nephew")   return "Aunt"
				if("Niece")    return "Aunt"


/datum/relation/family
	var/sex_restricted = null
	var/list/connected_relatives = list() //We use this so we can store multiple connected relations
	family_flag = 1
	finalized = 1

/datum/relation/family/get_desc_string()
	return "[connected_relation.relation_holder] is your [name]."

/datum/relation/family/mother
	name = "Mother"
	desc = "They gave birth to you."

/datum/relation/family/father
	name = "Father"
	desc = "They banged your mom."

/datum/relation/family/daughter
	name = "Daughter"
	desc = "They're your daughter."

/datum/relation/family/son
	name = "Son"
	desc = "They're your son."

/datum/relation/family/sister
	name = "Sister"
	desc = "They are your sister."

/datum/relation/family/brother
	name = "Brother"
	desc = "They are your brother."

/datum/relation/family/niece
	name = "Niece"
	desc = "They are your niece."

/datum/relation/family/nephew
	name = "Nephew"
	desc = "They are your Nephew."

/datum/relation/family/Uncle
	name = "Uncle"
	desc = "They are your Uncle."

/datum/relation/family/Aunt
	name = "Aunt"
	desc = "They are your Aunt."


/mob/living/carbon/human/verb/check_family()
	set hidden = 1
	var/message = "<big><b>Family:</b></big>\n"
	for(var/datum/relation/family/R in matchmaker.get_relationships(mind))
		message += "[R.connected_relation.relation_holder.current.name] is my [R.name].\n"
	to_chat(src, message)