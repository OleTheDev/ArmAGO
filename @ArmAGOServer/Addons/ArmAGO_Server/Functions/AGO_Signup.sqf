/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_Signup.sqf

Description:
Players can signup
*/
["AGO_Signup_DialogOpen",{
	if (AGO_matchLive) exitWith {
		["There is an ongoing match already, please wait!",AGO_Red] call AGO_MessageSystem;
	};
	closeDialog 1;
	createDialog "AGO_SignupDialog";

	{
		if (_x getVariable "AGO_playerSide" == "T") then {
			_readyStatus = [_x] call AGO_Signup_getReadyStatus;
			lbAdd[1500,format["%1 (%2)",name _x,_readyStatus]];
		};
		if (_x getVariable "AGO_playerSide" == "CT") then {
			_readyStatus = [_x] call AGO_Signup_getReadyStatus;
			lbAdd[1501,format["%1 (%2)",name _x,_readyStatus]];
		};
	} forEach playableUnits;

	buttonSetAction[1600,"['T'] call AGO_Signup_Join;"];
	buttonSetAction[1601,"['CT'] call AGO_Signup_Join;"];
	buttonSetAction[1602,"[] call AGO_Signup_ReadyStatus;"];
	buttonSetAction[1603,"[] call AGO_Signup_Leave;"];
}] call AGO_Function;

["AGO_Signup_getReadyStatus",{
	params["_player"];

	_return = "";
	if (_player getVariable "AGO_isReady") then {
		_return = "Ready";
	} else {
		_return = "Not ready";
	};

	_return;
}] call AGO_Function;

["AGO_Signup_Join",{
	params["_side"];

	if (player getVariable "AGO_playerSide" != "") exitWith {
		["You must leave your current team first!",AGO_Red] call AGO_MessageSystem;
	};

	if (_side isEqualTo "T") then {
		player setVariable["AGO_playerSide","T",true];
		["You have signed up for the Terrorist side!",AGO_Green] call AGO_MessageSystem;
	};
	if (_side isEqualTo "CT") then {
		player setVariable["AGO_playerSide","CT",true];
		["You have signed up for the Counter-Terrorist side!",AGO_Green] call AGO_MessageSystem;
	};

	[] call AGO_Match_warmupMode;
	[] call AGO_Match_setSpawnPoint;
	[] call AGO_Actions_Setup;
	[] call AGO_Signup_DialogOpen;
}] call AGO_Function;

["AGO_Signup_ReadyStatus",{
	if (player getVariable "AGO_isReady") then {
		player setVariable["AGO_isReady",false,true];
		["You have unreadyed!",AGO_Yellow] call AGO_MessageSystem;
	} else {
		player setVariable["AGO_isReady",true,true];
		["You are now ready!",AGO_Green] call AGO_MessageSystem;
	};
	[] call AGO_Signup_DialogOpen;
}] call AGO_Function;

["AGO_Signup_Leave",{
	if (player getVariable "AGO_playerSide" isEqualTo "") exitWith {
		["You are not apart of any teams!",AGO_Red] call AGO_MessageSystem;
	};
	player setVariable["AGO_playerSide","",true];
	player setPos (getMarkerPos "defaultSpawn");
	["You have successfully left your team.",AGO_Green] call AGO_MessageSystem;
	[] call AGO_Signup_DialogOpen;
}] call AGO_Function;
