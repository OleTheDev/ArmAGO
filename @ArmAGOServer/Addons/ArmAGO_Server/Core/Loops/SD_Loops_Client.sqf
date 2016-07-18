/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_Loops_Client.sqf
*/
SD_Client_MatchStart = {
	[] spawn {
		while {SD_MatchStarted} do {
			if (!(SD_BombPlanted)) then {
				hintSilent format ["Round Time left\n %1 Minute(s) and %2 Second(s)",SD_MatchTime_M,SD_MatchTime_S];
			} else {
				hintSilent format ["Bomb Time left\n %1 Minute(s) and %2 Second(s)",SD_BomBTime_M,SD_BomBTime_S];
			};
		};
	};
};
publicVariable "SD_Client_MatchStart";

SD_Client_XPCheck = {
	[] spawn {
		while {true} do {
			if (SD_XP >= SD_XPNeeded) then {
				SD_Rank = SD_Rank + 1;
				SD_XPNeeded = SD_XPNeeded + 30;
				[4,SD_XPNeeded,getPlayerUID player] remoteExec ["SD_DB_partialSync",2];
				[5,SD_Rank,getPlayerUID player] remoteExec ["SD_DB_partialSync",2];
			};
			sleep 1;
		};
	};
};
publicVariable "SD_Client_XPCheck";