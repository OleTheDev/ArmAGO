/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_Match.sqf

Description:
Match functions
*/

["AGO_Match_GetplayerReady",{
	private _CTPlayers = 0;
	private _TPlayers = 0;
	private _readyCTPlayers = 0;
	private _readyTPlayers = 0;
	private _return = false;

	{
		if (_x getVariable "AGO_playerSide" == "CT") then {
			_CTPlayers = _CTPlayers + 1;
		};
		if (_x getVariable "AGO_playerSide" == "T") then {
			_TPlayers = _TPlayers + 1;
		};
	} foreach playableUnits;
	{
		if (_x getVariable "AGO_isReady" && _x getVariable "AGO_playerSide" == "T") then {
			_readyTPlayers = _readyTPlayers + 1;
		};
		if (_x getVariable "AGO_isReady" && _x getVariable "AGO_playerSide" == "CT") then {
			_readyCTPlayers = _readyCTPlayers + 1;
		};
	} foreach playableUnits;

	_ctSideRdy = false;
	_tSideRdy = false;

	if (_CTPlayers isEqualTo _readyCTPlayers && _CTPlayers >= 1) then {
		_ctSideRdy = true;
	};
	if (_TPlayers isEqualTo _readyTPlayers && _TPlayers >= 1) then {
		_tSideRdy = true;
	};
	if (_ctSideRdy && _tSideRdy) then {
		_return = true;
	};

	_return;
}] call AGO_Function;

["AGO_Match_addCash",{
	params["_amount"];

	AGO_Cash = AGO_Cash + round(_amount);

	if (AGO_Cash > 16000) then {
		AGO_Cash = 16000;
	};
}] call AGO_Function;

["AGO_Match_resetCash",{
	AGO_Cash = 800;
}] call AGO_Function;

["AGO_Match_CheckAliveCT",{
	_ctAlive = 0;
	{
		if (_x getVariable "AGO_playerSide" == "CT") then {
			if (!(_x getVariable "AGO_isdead")) then {
				_ctAlive = _ctAlive + 1;
			};	
		};
	} forEach playableUnits;

	_ctAlive;
}] call AGO_Function;

["AGO_Match_CheckAliveT",{
	_tAlive = 0;
	{
		if (_x getVariable "AGO_playerSide" == "T") then {
			if (!(_x getVariable "AGO_isdead")) then {
				_tAlive = _tAlive + 1;
			};
		};
	} forEach playableUnits;

	_tAlive;
}] call AGO_Function;

["AGO_Match_CheckAlivePlayers",{
	[] spawn {
		while {AGO_roundLive} do {
			_aliveT = call AGO_Match_CheckAliveT;
			_aliveCT = call AGO_Match_CheckAliveCT;
			if (_aliveT <= 0) exitWith {
				AGO_score_CT = AGO_score_CT + 1;
				publicVariable "AGO_score_CT";
			};
			if (_aliveCT <= 0) exitWith {
				AGO_score_T = AGO_score_T + 1;
				publicVariable "AGO_score_T";
			};

			sleep 1;
		};
	}; 
}] call AGO_Function;

["AGO_Match_ServerLoop",{
	[] spawn {
		diag_log "Waiting for players...";
		AGO_warmupMode = true;
		publicVariable "AGO_warmupMode";

		[] remoteExec ["AGO_PlayerSetup_StartingGear"];
		waitUntil{call AGO_Match_GetplayerReady};
		["Match starting in 30 seconds!",AGO_Green] remoteExec["AGO_MessageSystem"];
		sleep 20;
		["Match starting in 10 seconds!",AGO_Green] remoteExec["AGO_MessageSystem"];
		sleep 10;
		["LIVE!",AGO_Green] remoteExec["AGO_MessageSystem"];

		AGO_matchLive = true;
		publicVariable "AGO_matchLive";

		AGO_warmupMode = false;
		publicVariable "AGO_warmupMode";

		[] remoteExec ["AGO_PlayerSetup_StartingGear"];
		[] remoteExec ["AGO_Match_resetCash"];

		while{AGO_matchLive} do {
			[] remoteExec ["AGO_Match_setSpawnPoint"];

			AGO_roundLive = false;
			publicVariable "AGO_roundLive";

			{
				_x setVariable["AGO_isDead",false,true];
			} foreach playableUnits;

			{
				deleteVehicle _x;
			} foreach allDead;

			private _cleanUp = 0;

			{
				_damage = getDammage _x;
				if (typeOf _x == "GroundWeaponHolder") then {
					deleteVehicle _x;
					_cleanUp = _cleanUp + 1;
				};

				if ((_damage > 0.8) && !(_x isKindOf "Man") && !(_x isKindOf "Car") && !(_x isKindOf "Air") && !(_x isKindOf "Ship")) then {
					_x setDamage 0;
					_cleanUp = _cleanUp + 1;
				};
			} forEach nearestObjects [getMarkerPos "t_spawn_1", [], 1000];

			if (_cleanUp >= 1) then {
				[format["::SERVER CLEANER:: Cleaned up %1 object(s)!",_cleanUp]] remoteExec ["systemChat"];
			};

			[format["Current Score: CT %1 - T %2",AGO_score_CT,AGO_score_T],AGO_Yellow] remoteExec ["AGO_MessageSystem"];	

			_timer = 20;
			for "_i" from 1 to 20 do {
				[format["Round starting in: \n%1 second(s)\nPress B to open shop menu!",_timer]] remoteExec ["hintSilent"];
				_timer = _timer - 1;

				sleep 1;
			};

			["Round is live!"] remoteExec ["hintSilent"];

			AGO_roundLive = true;
			publicVariable "AGO_roundLive";

			AGO_BombPlanted = false;
			publicVariable "AGO_BombPlanted";

			[] call AGO_Match_CheckAlivePlayers;

			_oldScore_T = AGO_score_T;
			_oldScore_CT = AGO_score_CT;

			waitUntil{_oldScore_T != AGO_score_T || _oldScore_CT != AGO_score_CT};

			if (_oldScore_T != AGO_score_T) then {
				{
					if (_x getVariable "AGO_playerSide" == "T") then {
						[2500] remoteExec["AGO_Match_addCash",_x];
						["Your team recived $2,500 for winning a round!",AGO_Green] remoteExec["AGO_MessageSystem",_x];
					};
					if (_x getVariable "AGO_playerSide" == "CT") then {
						[1200] remoteExec["AGO_Match_addCash",_x];
						["Your team recived $1,200 as lose bonus!",AGO_Green] remoteExec["AGO_MessageSystem",_x];
					};
				} foreach playableUnits;
			} else {
				{
					if (_x getVariable "AGO_playerSide" == "CT") then {
						[2500] remoteExec["AGO_Match_addCash",_x];
						["Your team recived $2,500 for winning a round!",AGO_Green] remoteExec["AGO_MessageSystem",_x];
					};
					if (_x getVariable "AGO_playerSide" == "T") then {
						[1200] remoteExec["AGO_Match_addCash",_x];
						["Your team recived $1,200 as lose bonus!",AGO_Green] remoteExec["AGO_MessageSystem",_x];
					};
				} foreach playableUnits;
			};

			AGO_roundsPlayed = AGO_roundsPlayed + 1;
			publicVariable "AGO_roundsPlayed";

			AGO_BombPlanted = false;
			publicVariable "AGO_BombPlanted";

			sleep 15;

			if (AGO_roundsPlayed isEqualTo AGO_maxRounds || AGO_score_T isEqualTo 16 || AGO_score_CT isEqualTo 16) exitWith {
				[] remoteExec["AGO_Match_Finished"];

				sleep 5;

				AGO_roundsPlayed = 0;
				publicVariable "AGO_roundsPlayed";
				AGO_roundLive = false;
				publicVariable "AGO_roundLive";
				AGO_score_T = 0;
				publicVariable "AGO_score_T";
				AGO_score_CT = 0;
				publicVariable "AGO_score_CT";
				AGO_matchLive = false;
				publicVariable "AGO_matchLive";
			};
			if (AGO_roundsPlayed isEqualTo AGO_halftimeRound) then {
				["Switching sides!",AGO_Yellow] remoteExec["AGO_MessageSystem"];

				_tScore = AGO_score_T;
				_ctScore = AGO_score_CT;
				AGO_score_T = _ctScore;
				AGO_score_CT = _tScore;
				publicVariable "AGO_score_T";
				publicVariable "AGO_score_CT";

				{
					_player = _x;
					if (_player getVariable "AGO_playerSide" == "CT") then {
						_player setVariable ["AGO_playerSide","T",true];
					} else {
						if (_player getVariable "AGO_playerSide" == "") exitWith {};
						_player setVariable["AGO_playerSide","CT",true];
					};

					[] remoteExec ["AGO_Match_resetCash"];
				} forEach playableUnits;

				[] remoteExec ["AGO_PlayerSetup_StartingGear"];

				sleep 3;
			};
		};

		sleep 2;

		[] call AGO_Match_ServerLoop;
	};
}] call AGO_Function;

["AGO_Match_Finished",{
	if (AGO_score_T > AGO_score_CT) then {
		[format["Terrorists wins! Final score: (T) %1 - (CT) %2",AGO_score_T,AGO_score_CT],AGO_Yellow] call AGO_MessageSystem;
	} else {
		[format["Counter-Terrorists wins! Final score: (CT) %1 - (T) %2",AGO_score_CT,AGO_score_T],AGO_Yellow] call AGO_MessageSystem;
	};

	hint format["Your end score\nKill(s): %1\nDeath(s): %2",AGO_Kills,AGO_Deaths];

	player setVariable["AGO_playerSide","",true];
	player setVariable["AGO_isReady",false,true];
	player setVariable["AGO_isdead",false,true];

	player setPos (getMarkerPos "defaultSpawn");
}] call AGO_Function;

["AGO_Match_warmupMode",{
	[] spawn {
		if (AGO_matchLive isEqualTo false && player getVariable "AGO_playerSide" != "") then {
			AGO_Cash = 16000;
		};
		while {AGO_matchLive isEqualTo false && player getVariable "AGO_playerSide" != ""} do {
			hintSilent "Waiting for players... \nWarmup mode is enabled!\nPress B for Shop menu!";
			sleep 1;
		};
		hintSilent "";
	};
}] call AGO_Function;

["AGO_Match_setSpawnPoint",{
	[] spawn {
		if (player getVariable "AGO_playerSide" isEqualTo "") exitWith {};

		_side = player getVariable "AGO_playerSide";
		player enableSimulation true;
		player allowDamage true;
		player setDamage 0;
		if (_side isEqualTo "T") then {
			_tSpawns = [];
			_amount = 1;
			for "_i" from 1 to 10 do {
				_markerName = format["t_spawn_%1",_amount];
				_tSpawns pushBack _markerName;
				_amount = _amount + 1;
			};

			_spawnPoint = selectRandom _tSpawns;
			_dir = markerDir _spawnPoint;
			player setPos (getMarkerPos _spawnPoint);

			_attachObj = "KartSteertingWheel_01_yellow_F" createVehicleLocal (getPos player);
			_attachObj hideObject true;
			_attachObj setDir _dir;
			player attachTo[_attachObj];
			player setDir _dir;

			if (!(AGO_matchLive)) exitWith {
				deleteVehicle _attachObj;
				detach player;
			};

			waitUntil{AGO_roundLive};

			deleteVehicle _attachObj;
			detach player;
		} else {
			_ctSpawns = [];
			_amount = 1;
			for "_i" from 1 to 10 do {
				_markerName = format["ct_spawn_%1",_amount];
				_ctSpawns pushBack _markerName;
				_amount = _amount + 1;
			};

			_spawnPoint = selectRandom _ctSpawns;
			_dir = markerDir _spawnPoint;
			player setPos (getMarkerPos _spawnPoint);

			_attachObj = "KartSteertingWheel_01_yellow_F" createVehicleLocal (getPos player);
			_attachObj hideObject true;
			_attachObj setDir _dir;
			player attachTo[_attachObj];
			player setDir _dir;

			if (!(AGO_matchLive)) exitWith {
				deleteVehicle _attachObj;
				detach player;
			};

			waitUntil{AGO_roundLive};

			deleteVehicle _attachObj;
			detach player;
		};
	};
}] call AGO_Function;

[] call AGO_Match_ServerLoop;