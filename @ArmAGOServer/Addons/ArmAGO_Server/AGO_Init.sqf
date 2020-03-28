#include "\ArmAGO_Server\macros.hpp"
/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_Init.sqf

Description:
Loading the server sided files and load them back to the client
*/

AGO_Server_init = {
	private ["_Functions","_folder","_sqf"];
	_extDBNotLoaded = "";

	_Functions = [
		//Folder, Script file name
		/*
			Exampel:
			["FolderNameHere","ScriptFileNameHere"],
			["FolderNameHere1","ScriptFileNameHere1"],
			["FolderNameHere2","ScriptFileNameHere2"],
			["FolderNameHere3","ScriptFileNameHere3"]
		*/
		//Init
		["", "AGO_ServerVars"],
		["", "AGO_Onkeypress"],
		["", "AGO_Shop"],
		["", "AGO_Shop_Config"],
		["", "AGO_PlayerVars"],
		["", "AGO_PlayerSetup"],
		["", "AGO_MessageSys"],
		["", "AGO_Signup"],
		["", "AGO_Network"],
		["", "AGO_Bomb"],
		["", "AGO_Actions"],
		["", "AGO_Match"]
	];

	_folder = "";
	_sqf = "";

	{
		_folder = _x select 0;
		_sqf = _x select 1;


		if (!(_folder == "")) then {

			diag_log format ["Loading File: \ArmAGO_Server\Functions\%1\%2",_sqf];
			[] execVM format ["\ArmAGO_Server\Functions\%1\%2.sqf",_folder,_sqf];
			diag_log format ["File Loaded: \ArmAGO_Server\Functions\%1\%2",_folder,_sqf];

		} else {

			diag_log format ["Loading File: \ArmAGO_Server\Functions\%1",_sqf];
			[] execVM format ["\ArmAGO_Server\Functions\%1.sqf",_sqf];
			diag_log format ["File Loaded: \ArmAGO_Server\Functions\%1",_sqf];
			
		};

	} foreach _Functions;

	if (isNil {uiNamespace getVariable "AGO_SQL_ID"}) then {
	    AGO_SQL_ID = round(random(9999));
	    CONSTVAR(AGO_SQL_ID);
	    uiNamespace setVariable ["AGO_SQL_ID",AGO_SQL_ID];
        try {
        _result = EXTDB format ["9:ADD_DATABASE:%1","Database"];
        if (!(_result isEqualTo "[1]")) then {throw "extDB3: Error with Database Connection"};
        _result = EXTDB format ["9:ADD_DATABASE_PROTOCOL:%2:SQL:%1:TEXT2",FETCH_CONST(AGO_SQL_ID),"Database"];
        if (!(_result isEqualTo "[1]")) then {throw "extDB3: Error with Database Connection"};
    } catch {
        diag_log _exception;
        _extDBNotLoaded = [true, _exception];
    };

	if (_extDBNotLoaded isEqualType []) exitWith {};
	    EXTDB "9:LOCK";
	    diag_log "extDB3: Connected to Database";
	} else {
	    AGO_SQL_ID = uiNamespace getVariable "AGO_SQL_ID";
	    CONSTVAR(AGO_SQL_ID);
	    diag_log "extDB3: Still Connected to Database";
	};

	AGO_SRV_READY = true;
	publicVariable "AGO_SRV_READY";
};

AGO_Function = {
	private ["_name","_Content","_Private"];
	_Name = [_this, 0] call BIS_fnc_param;
	_Content = [_this, 1] call BIS_fnc_param;
	_Private = [_this, 2, false] call BIS_fnc_param;

	call compile format ["%1 = %2;", _Name, _Content];

	if(!_Private) then { publicVariable _Name; };
};

[] call AGO_Server_init;
