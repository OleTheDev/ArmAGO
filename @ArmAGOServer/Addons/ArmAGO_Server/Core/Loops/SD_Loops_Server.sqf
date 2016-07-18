/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_Loops_Server.sqf
*/
SD_Loops_Server_StartMatch = {
	if (!(isServer)) exitWith {};

	[] spawn {
		private ["_c","_p","_notReady"];
		while {true} do {
			_c = false;
			if (SD_MatchQue <= SD_TeamRedCount && SD_MatchQue <= SD_TeamBlueCount) then {
				_notReady = 0;

				{
					_p = _x select 1;
					if (!(_p getVariable "SD_PlayerReady")) then {
						_notReady = _notReady + 1;
					};
				} count SD_TeamRed;
				{
					_p = _x select 1;
					if (!(_p getVariable "SD_PlayerReady")) then {
						_notReady = _notReady + 1;
					};
				} count SD_TeamBlue;

				if (_notReady >= 1) exitWith {
					_msg = format ["Waiting for %1/%2 player(s) in que to ready up.",_notReady,SD_InQue];
					[_msg] call SD_Message_Global;
				};

				_msg = "Match Started.";
				[_msg] call SD_Message_Global;
				[] remoteExec ["SD_Match_Teleport"];
				_c = true;
			} else {
				_msg = "The server is waiting for players to que up...";
				[_msg] call SD_Message_Global;
			};
			if (_c) exitWith {};
			sleep 5;
		};
	};
};
publicVariable "SD_Loops_Server_StartMatch";

[] call SD_Loops_Server_StartMatch;

SD_Loops_Server_Match = {
	[] spawn {
		while {SD_MatchStarted} do {
			if (SD_MatchTime_S <= 0 && SD_MatchTime_M >= 1) then {
				SD_MatchTime_M = SD_MatchTime_M - 1;
				SD_MatchTime_S = 59;

				publicVariable "SD_MatchTime_M";
				publicVariable "SD_MatchTime_S";
			};
			if (SD_MatchTime_S <= 0 && SD_MatchTime_M <= 0) exitWith {
				_msg = "Round timer ran out so Team Blue win.";
				["Team Blue"] call SD_TeamWon;
				[_msg] call SD_Message_Global;
				SD_BombPlanted = false;
				publicVariable "SD_BombPlanted";
				SD_TeamBluePlant = false;
				publicVariable "SD_TeamBluePlant";
				SD_TeamRedPlant = false;
				publicVariable "SD_TeamRedPlant";
				SD_MatchStarted = false;
				publicVariable "SD_MatchStarted";

				SD_ScoreBlue = SD_ScoreBlue + 1;
				publicVariable "SD_ScoreBlue";

				sleep 5;
				[] remoteExec ["SD_Match_Teleport"];
			};
			
			if (SD_TeamBlueAlive <= 0) exitWith {
				["Team Red"] call SD_TeamWon;
				["Team Red won the because all the Team Blue members died."] call SD_Message_Global;
				SD_BombPlanted = false;
				publicVariable "SD_BombPlanted";
				SD_TeamBluePlant = false;
				publicVariable "SD_TeamBluePlant";
				SD_TeamRedPlant = false;
				publicVariable "SD_TeamRedPlant";
				SD_MatchStarted = false;
				publicVariable "SD_MatchStarted";

				SD_ScoreRed = SD_ScoreRed + 1;
				publicVariable "SD_ScoreBlue";

				sleep 5;
				[] remoteExec ["SD_Match_Teleport"];
			};
			if (SD_TeamRedAlive <= 0) exitWith {
				["Team Blue"] call SD_TeamWon;
				["Team Blue won the because all the Team Red members died."] call SD_Message_Global;
				SD_BombPlanted = false;
				publicVariable "SD_BombPlanted";
				SD_TeamBluePlant = false;
				publicVariable "SD_TeamBluePlant";
				SD_TeamRedPlant = false;
				publicVariable "SD_TeamRedPlant";
				SD_MatchStarted = false;
				publicVariable "SD_MatchStarted";

				SD_ScoreBlue = SD_ScoreBlue + 1;
				publicVariable "SD_ScoreBlue";

				sleep 5;
				[] remoteExec ["SD_Match_Teleport"];
			};

			SD_MatchTime_S = SD_MatchTime_S - 1;
			publicVariable "SD_MatchTime_S";
			sleep 1;
		};
	};
};
publicVariable "SD_Loops_Server_Match";

SD_Loops_Server_Bomb = {
	[] spawn {
		while {SD_BombPlanted} do {
			if (SD_BomBTime_S <= 0 && SD_BomBTime_M >= 1) then {
				SD_BomBTime_M = SD_BomBTime_M - 1;
				SD_BomBTime_S = 59;

				publicVariable "SD_BomBTime_M";
				publicVariable "SD_BomBTime_S";
			};
			if (SD_BomBTime_S <= 0 && SD_BomBTime_M <= 0) exitWith {
				"Bo_GBU12_LGB" createVehicle getPos Bomb;
				SD_BombPlanted = false;
				publicVariable "SD_BombPlanted";

				if (SD_TeamBluePlant) then {
					_msg = "Team Blue Won the round for planting the bomb.";
					[_msg] call SD_Message_Global;

					SD_ScoreBlue = SD_ScoreBlue + 1;
					publicVariable "SD_ScoreBlue";

					["Team Blue"] call SD_TeamWon;
				};
				if (SD_TeamRedPlant) then {
					_msg = "Team Red Won the round for planting the bomb.";
					[_msg] call SD_Message_Global;

					SD_ScoreRed = SD_ScoreRed + 1;
					publicVariable "SD_ScoreRed";

					["Team Red"] call SD_TeamWon;
				};

				sleep 5;
				[] remoteExec ["SD_Match_Teleport"];
				SD_BombPlanted = false;
				publicVariable "SD_BombPlanted";
				SD_TeamBluePlant = false;
				publicVariable "SD_TeamBluePlant";
				SD_TeamRedPlant = false;
				publicVariable "SD_TeamRedPlant";
				SD_MatchStarted = false;
				publicVariable "SD_MatchStarted";
			};

			SD_BomBTime_S = SD_BomBTime_S - 1;
			publicVariable "SD_BomBTime_S";
			sleep 1;
		};
	};
};
publicVariable "SD_Loops_Server_Bomb";