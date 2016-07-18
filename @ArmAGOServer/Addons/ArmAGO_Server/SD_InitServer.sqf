#include "\ArmAGO_Server\macros.hpp"
/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_InitServer.sqf
*/
SD_SRV_READY = false;
SD_extDB_Error = "";
publicVariable "SD_SRV_READY";

SD_InitServer = {
	_Files =
	[
		//Folder, File

		//Core
		["Core","SD_Cfg"],
		["Core","SD_LIB"],
		["Core","SD_Que"],
		["Core","SD_Match"],
		["Core","SD_KeyPress"],
		["Core","SD_Actions"],
		["Core","SD_Bomb"],
		["Core","SD_Hud"],

		//Spawn
		["Core\Spawn","SD_Spawn"],

		//Server
		["Core\Server","SD_ServerVars"],

		//Loops
		["Core\Loops","SD_Loops_Client"],
		["Core\Loops","SD_Loops_Server"],

		//Buy
		["Core\Buy","SD_Buy_Cfg"],
		["Core\Buy","SD_BuyMenu"],

		//extDB
		["extDB","SD_extDB"]
	];

	{
		[] execVM format ["\ArmAGO_Server\%1\%2.sqf",_x select 0,_x select 1];
	} foreach _Files;

	if(isNil {uiNamespace getVariable "SD_SQL_ID"}) then {
		SD_SQL_ID = round(random(9999));
		CONSTVAR(SD_SQL_ID);
		uiNamespace setVariable ["SD_SQL_ID", SD_SQL_ID];
		try {
			_result = "extDB2" callExtension format["9:ADD_DATABASE:%1",'ArmAGO'];
			if(!(EQUAL(_result,"[1]"))) then {throw "extDB2: Error with Adding Database Connection"};
			_result = "extDB2" callExtension format["9:ADD_DATABASE_PROTOCOL:%2:SQL_RAW_V2:%1:ADD_QUOTES",call SD_SQL_ID,'ArmAGO'];
			if(!(EQUAL(_result,"[1]"))) then {throw "extDB2: Error with Database Protocol"};
		} catch {
			diag_log _exception;
			SD_extDB_Error = [true, _exception];
		};
		publicVariable "SD_extDB_Error";
		if(SD_extDB_Error isEqualType []) exitWith {};
		"extDB2" callExtension "9:LOCK";
		diag_log "extDB2: Connected to Database";
	} else {
		SD_SQL_ID = uiNamespace getVariable "SD_SQL_ID";
		CONSTVAR(SD_SQL_ID);
		diag_log "extDB2: Still Connected to Database";
	};

	if(SD_extDB_Error isEqualType []) exitWith {};

	SD_SRV_READY = true;
	publicVariable "SD_SRV_READY";
};

[] call SD_InitServer;