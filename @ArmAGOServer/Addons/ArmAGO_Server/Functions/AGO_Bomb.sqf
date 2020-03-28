/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_Bomb.sqf

Description:
Bomb
*/
["AGO_Bomb_Plant",{
	[_this select 0] spawn {
		params["_site"];
		if (player getVariable "AGO_playerSide" != "T") exitWith {
			["Your not a terrorist!",AGO_Red] call AGO_MessageSystem;
		};
		if (AGO_BombPlanted) exitWith {
			["The bomb is already planted!",AGO_Red] call AGO_MessageSystem;
		};
		if (AGO_warmupMode) exitWith {
			["You may not plant the bomb while in warmup mode!",AGO_Red] call AGO_MessageSystem;
		};
		if (player getVariable "AGO_isdead") exitWith {};
		_bombSite = cursorObject;
		if (player distance cursorObject > 5) exitWith {
			["You must get closer!",AGO_Red] call AGO_MessageSystem;
		};

		["AinvPknlMstpSnonWnonDnon_medic_1","playmove"] call AGO_SwitchAnim_Global;

		for "_i" from 0 to 3 do {
			["AinvPknlMstpSnonWnonDnon_medic_1","playmove"] call AGO_SwitchAnim_Global;
			sleep 1.5;
			waitUntil{animationState player != "AinvPknlMstpSnonWnonDnon_medic_1"};
			if (player getVariable "AGO_isdead") exitWith {};
			if (player distance cursorObject > 5) exitWith {};
		};

		sleep (random 3);

		if (player getVariable "AGO_isdead") exitWith {};	
		if (AGO_BombPlanted) exitWith {
			["The bomb is already planted!",AGO_Red] call AGO_MessageSystem;
		};

		AGO_BombPlanted = true;
		publicVariable "AGO_BombPlanted";

		[350] call AGO_Match_addCash;
		["You recived $350 for planting the bomb!",AGO_Green] call AGO_MessageSystem;
		[_site] remoteExec["AGO_Bomb_Plant_ServerLoop",2];
		[format["Bomb has been planted on %1 site!",_site],AGO_Yellow] remoteExec ["AGO_MessageSystem"];
	};
	
}] call AGO_Function;

["AGO_Bomb_Plant_ServerLoop",{
	[_this select 0] spawn {
		params["_site"];

		_seconds = 59;
		_bombTime = AGO_BombTime;
		[format["%1 minutes and %2 seconds left until bomb goes off!",_bombTime,_seconds],AGO_Yellow] remoteExec ["AGO_MessageSystem"];

		while {AGO_BombPlanted} do {
			if (_seconds <= 0 && _bombTime >= 1) then {
				_bombTime = _bombTime - 1;
				_seconds = 59;
			};
			if (_bombTime isEqualTo 1 && _seconds isEqualTo 60) then {
				[format["%1 minute left until bomb goes off!",_bombTime],AGO_Yellow] remoteExec ["AGO_MessageSystem"];
			};
			if (_seconds <= 0 && _bombTime <= 0) exitWith {
				if (_site isEqualTo "A") then {
					"Bomb_04_F" createVehicle (getPos bomb_a);
				} else {
					"Bomb_04_F" createVehicle (getPos bomb_b);
				};

				AGO_score_T = AGO_score_T + 1;
				publicVariable "AGO_score_T";

				[format["Terrorist wins! CT %1 - T %2",AGO_score_CT,AGO_score_T],AGO_Yellow] remoteExec ["AGO_MessageSystem"];			

				AGO_BombPlanted = false;
				publicVariable "AGO_BombPlanted";

				{
					if (_x getVariable "AGO_playerSide" == "T") then {
						[1500] remoteExec["AGO_Match_addCash",_x];
						["Your team recived $1,500 for winning and planting the bomb!",AGO_Green] remoteExec["AGO_MessageSystem",_x];
					};
				} foreach playableUnits;
			};
			if (AGO_BombDefused) exitWith {
				AGO_score_CT = AGO_score_CT + 1;
				publicVariable "AGO_score_CT";

				AGO_BombPlanted = false;
				publicVariable "AGO_BombPlanted";

				AGO_BombDefused = false;
				publicVariable "AGO_BombDefused";

				[format["Counter-Terrorist wins! CT %1 - T %2",AGO_score_CT,AGO_score_T],AGO_Yellow] remoteExec ["AGO_MessageSystem"];
			};
			sleep 1;
			_seconds = _seconds - 1;

			[format["BOMB TIMER \nMinute(s): %1 \nSecond(s) %2",_bombTime,_seconds]] remoteExec["hintSilent"];
		};

		[""] remoteExec["hintSilent"];

		AGO_BombPlanted = false;
		publicVariable "AGO_BombPlanted";

		AGO_BombDefused = false;
		publicVariable "AGO_BombDefused";
	};
	
}] call AGO_Function;