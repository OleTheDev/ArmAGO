/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_Match.sqf
*/
SD_Match_FinalScore = {
	SD_TeamRed = [];
	SD_TeamBlue = [];
	SD_TeamRedCount = 0; //Amount of team red players
	SD_TeamBlueCount = 0; //Amount of team blue players
	SD_InQue = 0; //Amount of players in que
	SD_Ready = 0; //Amount of players ready to start
	SD_MatchQue = 1;
	SD_MatchStarted = false;
	SD_ScoreRed = 0; //Score team red
	SD_ScoreBlue = 0; //Score team Blue
	SD_RoundBuy = false;
	SD_BombPlanted = false;
	SD_TeamRedPlant = false;
	SD_TeamBluePlant = false;

	publicVariable "SD_TeamRed";
	publicVariable "SD_TeamBlue";
	publicVariable "SD_TeamRedCount";
	publicVariable "SD_TeamBlueCount";
	publicVariable "SD_InQue";
	publicVariable "SD_Ready";
	publicVariable "SD_MatchQue";
	publicVariable "SD_MatchStarted";
	publicVariable "SD_ScoreRed";
	publicVariable "SD_ScoreBlue";
	publicVariable "SD_RoundBuy";
	publicVariable "SD_BombPlanted";
	publicVariable "SD_TeamRedPlant";
	publicVariable "SD_TeamBluePlant";

	[] call SD_Loops_Server_StartMatch;
};
publicVariable "SD_Match_FinalScore";

SD_Match_Teleport = {
	player setDamage 0;

	SD_TeamRedAlive = 0;
	SD_TeamBlueAlive = 0;
	publicVariable "SD_TeamRedAlive";
	publicVariable "SD_TeamBlueAlive";

	if (SD_ScoreRed isEqualTo SD_TeamWinningScore) exitWith {
		[format ["The Final score is: %1 to TeamRed and %2 to TeamRed so TeamRed Wins!",SD_ScoreRed,SD_ScoreBlue]] call SD_Message_Global;
		player setpos (getMarkerpos "Spawn");
		[] remoteExec ["SD_Match_FinalScore",2];
		hint "New match is now waiting for players...";
		player setVariable ["SD_PlayerReady",false,true];
		player setVariable ["SD_TeamRed",false,true];
		player setVariable ["SD_TeamBlue",false,true];
		player setVariable ["SD_InMatch",false,true];
		player setVariable ["SD_Dead",false,true];

		SD_Wins = SD_Wins + 1;
		[2,SD_Wins,getPlayerUID player] remoteExec ["SD_DB_partialSync",2];
	};

	if (SD_ScoreBlue isEqualTo SD_TeamWinningScore) exitWith {
		[format ["The Final score is: %1 to TeamRed and %2 to TeamBlue so TeamBlue Wins!",SD_ScoreRed,SD_ScoreBlue]] call SD_Message_Global;
		player setpos (getMarkerpos "Spawn");
		[] remoteExec ["SD_Match_FinalScore",2];
		hint "New match is now waiting for players...";
		player setVariable ["SD_PlayerReady",false,true];
		player setVariable ["SD_TeamRed",false,true];
		player setVariable ["SD_TeamBlue",false,true];
		player setVariable ["SD_InMatch",false,true];
		player setVariable ["SD_Dead",false,true];

		SD_Wins = SD_Wins + 1;
		[2,SD_Wins,getPlayerUID player] remoteExec ["SD_DB_partialSync",2];
	};

	if (player getVariable "SD_TeamRed") exitWith {
		SD_TeamRedAlive = SD_TeamRedAlive + 1;
		publicVariable "SD_TeamRedAlive";
		player setpos (getMarkerPos "Red_Spawn");
		player enableSimulation false;
		[] call SD_Match_RoundStart;
		player setVariable ["SD_InMatch",true,true];

		player forceAddUniform "U_O_CombatUniform_oucamo";
		if (currentWeapon player isEqualTo "") then {
			player addWeapon "hgun_P07_snds_F";
			player addMagazines ["30Rnd_9x21_Mag",5];

			SD_CurrentGear = SD_CurrentGear + [ ["Pistols","hgun_P07_snds_F","30Rnd_9x21_Mag"] ];
		} else {
			[] call SD_BuyMenu_RecreateGear;
		};
	};
	if (player getVariable "SD_TeamBlue") exitWith {
		SD_TeamBlueAlive = SD_TeamBlueAlive + 1;
		publicVariable "SD_TeamBlueAlive";
		player setpos (getMarkerPos "Blue_Spawn");
		player enableSimulation false;
		[] call SD_Match_RoundStart;
		player setVariable ["SD_InMatch",true,true];

		player forceAddUniform "U_B_CombatUniform_mcam";
		if (currentWeapon player isEqualTo "") then {
			player addWeapon "hgun_P07_snds_F";
			player addMagazines ["30Rnd_9x21_Mag",5];

			SD_CurrentGear = SD_CurrentGear + [ ["Pistols","hgun_P07_snds_F","30Rnd_9x21_Mag"] ];
		} else {
			[] call SD_BuyMenu_RecreateGear;
		};
	};
};
publicVariable "SD_Match_Teleport";

SD_Match_RoundStart = {
	[] spawn {
		SD_BomBTime_M = 2;
		SD_BomBTime_S = 0;
		SD_MatchTime_M = 5;
		SD_MatchTime_S = 5;
		publicVariable "SD_BomBTime_M";
		publicVariable "SD_BomBTime_S";
		publicVariable "SD_MatchTime_M";
		publicVariable "SD_MatchTime_S";

		player setDamage 0;
		player switchmove "";

		hint format ["Round Started. \nCurrent Score \nTeam Red %1 - %2 Team Blue",SD_ScoreRed,SD_ScoreBlue];
		SD_MatchStarted = false;
		publicVariable "SD_MatchStarted";
		[] call SD_Match_StartTimer;
		waitUntil{SD_MatchStarted};
		player enableSimulation true;
		hint "Round Started.";
	};
};
publicVariable "SD_Match_RoundStart";

SD_Match_StartTimer = {
	[] spawn {
		_Seconds = 40;
		SD_RoundBuy = true;
		publicVariable "SD_RoundBuy";

		while {true} do {
			titleText[format["Round Start in %1 Second(s)",_Seconds],"PLAIN"];
			if (_Seconds <= 0) exitWith {
				SD_MatchStarted = true;
				publicVariable "SD_MatchStarted";
				titleText[format["Round Started.",name player], "PLAIN"];

				[] call SD_Loops_Server_Match;
				[] call SD_Client_MatchStart;
				SD_RoundBuy = false;
				publicVariable "SD_RoundBuy";
			};
			sleep 1;
			_Seconds = _Seconds - 1;
		};
	};
};
publicVariable "SD_Match_StartTimer";