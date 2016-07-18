/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_Bomb.sqf
*/
SD_Bomb_Plant = {
	[] spawn {
		if (player getVariable "SD_TeamBlue") exitWith {
			hint "You are a defender.";
		};
		if (SD_BombPlanted) exitWith {
			hint "The Bomb is already planted.";
		};
		player playmove "AinvPknlMstpSnonWnonDnon_medic_1";

		waitUntil {animationState player != "AinvPknlMstpSnonWnonDnon_medic_1"};
		if (player getVariable "SD_Dead") exitWith {};
		sleep 3;
		player playmove "AinvPknlMstpSnonWnonDnon_medic_1";

		waitUntil {animationState player != "AinvPknlMstpSnonWnonDnon_medic_1"};

		if (player getVariable "SD_Dead") exitWith {};
		sleep 3;
		[] remoteExec ["SD_Loops_Server_Bomb",2];

		SD_BombPlanted = true;
		publicVariable "SD_BombPlanted";

		if (player getVariable "SD_TeamRed") then {
			SD_TeamRedPlant = true;
			SD_TeamBluePlant = false;

			publicVariable "SD_TeamRedPlant";
			publicVariable "SD_TeamBluePlant";

			_msg = format ["%1 Just planted the bomb for Team Red.",name player];
			[_msg] call SD_Message_Global;
		} else {
			SD_TeamBluePlant = true;
			SD_TeamRedPlant = false;

			publicVariable "SD_TeamBluePlant";
			publicVariable "SD_TeamRedPlant";

			_msg = format ["%1 Just planted the bomb for Team Blue.",name player];
			[_msg] call SD_Message_Global;
		};

		SD_XP = SD_XP + 5;

		[3,SD_XP,getPlayerUID player] remoteExec ["SD_DB_partialSync",2];
	};
};
publicVariable "SD_Bomb_Plant";

SD_Bomb_Defuse = {
	[] spawn {
		if (!(SD_BombPlanted)) exitWith {
			systemChat "The Bomb is not planted.";
		};

		if (player getVariable "SD_TeamRed" && SD_TeamRedPlant) exitWith {
			systemChat "You can't defuse the bomb that your own team planted.";
		};
		if (player getVariable "SD_TeamBlue" && SD_TeamBluePlant) exitWith {
			systemChat "You can't defuse the bomb that your own team planted.";
		};
		if (player getVariable "SD_TeamRed") then {
			_msg = format ["%1 Defused the bomb for Team Red",name player];
			[_msg] call SD_Message_Global;
		};
		if (player getVariable "SD_TeamBlue") then {
			_msg = format ["%1 Defused the bomb for Team Blue",name player];
			[_msg] call SD_Message_Global;
		};

		player playmove "AinvPknlMstpSnonWnonDnon_medic_1";

		waitUntil {
			animationState player != "AinvPknlMstpSnonWnonDnon_medic_1";
			if (player getVariable "SD_Dead") exitWith {};
		};

		if (player getVariable "SD_Dead") exitWith {};

		sleep 3;

		player playmove "AinvPknlMstpSnonWnonDnon_medic_1";

		waitUntil {
			animationState player != "AinvPknlMstpSnonWnonDnon_medic_1";
			if (player getVariable "SD_Dead") exitWith {};
		};

		sleep 3;

		if (player getVariable "SD_Dead") exitWith {};

		SD_XP = SD_XP + 5;

		[3,SD_XP,getPlayerUID player] remoteExec ["SD_DB_partialSync",2];

		SD_BombPlanted = false;
		SD_BomBTime_M = 2;
		SD_BomBTime_S = 0;

		publicVariable "SD_BombPlanted";
		publicVariable "SD_BomBTime_M";
		publicVariable "SD_BomBTime_S";
	};
};
publicVariable "SD_Bomb_Defuse";