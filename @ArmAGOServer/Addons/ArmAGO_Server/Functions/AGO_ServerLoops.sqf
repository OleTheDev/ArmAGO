/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_ServerLoops.sqf

Description:
Server Loops
*/

[] spawn {
	while {true} do {
		sleep 0.5;
		{
			if (!(_x getVariable["AGO_isDead",false])) then {
				deleteVehicle _x;
			};
		} foreach allDeadMen;
	};	
};