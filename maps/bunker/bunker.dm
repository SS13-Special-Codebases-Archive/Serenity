#if !defined(using_map_DATUM)

	#include "../shared/exodus_torch/_include.dm"



	//CONTENT
	#include "../shared/job/jobs.dm"

	#include "bunker-1.dmm"
	#include "bunker-2.dmm"
	#include "bunker-3.dmm"
	#include "bunker-4.dmm"


	#include "../shared/exodus_torch/_include.dm"

	#include "../../code/modules/lobby_music/museum.dm"
	#include "../../code/modules/lobby_music/absconditus.dm"
	#include "../../code/modules/lobby_music/space_oddity.dm"
	#include "../../code/modules/lobby_music/undercurrent.dm"
	#include "../../code/modules/lobby_music/conquer.dm"
	#include "../../code/modules/lobby_music/generic_songs.dm"
	#include "../../code/modules/lobby_music/docking.dm"

	#define using_map_DATUM /datum/map/bunker

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Frontier
#endif
