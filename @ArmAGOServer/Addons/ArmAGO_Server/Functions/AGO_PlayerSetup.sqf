/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_PlayerSetup.sqf

Description:
Player Setup
*/

["AGO_PlayerSetup_Start",{
	[] spawn {
		_clientCalls = ["AGO_PlayerVars_Setup","AGO_KeyHandler"];
		{
			_fnc = _x;
			call compile format["[] call %1;",_fnc];;
			systemChat format["::ArmA GO Client Call:: %1",_x];
		} foreach _clientCalls;

		player enableSimulation true;

		_array = [format["Welcome %1 to ArmA GO...",name player],"Please press Y once your ready to join a team.","Enjoy your stay!"];
		{
			_msg = _x;
			[_msg,AGO_Green] call AGO_MessageSystem;
			sleep 5;
		} forEach _array;
	};
}] call AGO_Function;

["AGO_PlayerSetup_StartingGear",{
	private["_currentSide"];
	_currentSide = player getVariable "AGO_playerSide";

	removeHeadgear player;
	removeAllWeapons player;
	removeUniform player;
	removeBackpack player;
	removeVest player;

	{
		_classname = _x select 0;
		_side = _x select 1;
		_cmd = _x select 2;
		if (_side == _currentSide) then {
			call compile format["player %1 '%2';",_cmd,_classname];
		};
	} foreach AGO_startingoutfit;
}] call AGO_Function;