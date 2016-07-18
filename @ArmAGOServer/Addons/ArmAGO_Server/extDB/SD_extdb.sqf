#include "\ArmAGO_Server\macros.hpp"
/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_extDB.sqf
*/
SD_DB_ASYNC = {
	private["_queryStmt","_mode","_multiarr","_queryResult","_key","_return","_loop"];
	_queryStmt = [_this,0,"",[""]] call BIS_fnc_param;
	_mode = [_this,1,1,[0]] call BIS_fnc_param;
	_multiarr = [_this,2,false,[false]] call BIS_fnc_param;

	_key = EXTDB format["%1:%2:%3",_mode,FETCH_CONST(SD_SQL_ID),_queryStmt];

	if(EQUAL(_mode,1)) exitWith {true};

	_key = call compile format["%1",_key];
	_key = SEL(_key,1);

	_queryResult = "";
	_loop = true;
	while{_loop} do {
		_queryResult = "extDB2" callExtension format["4:%1", _key];
		if (EQUAL(_queryResult,"[5]")) then {
			_queryResult = "";
			for "_i" from 0 to 1 step 0 do {
				_pipe = EXTDB format["5:%1", _key];
				if(_pipe == "") exitWith {_loop = false};
				_queryResult = _queryResult + _pipe;
			};
		} else {
			if (!(EQUAL(_queryResult,"[3]"))) then {
				_loop = false;
			};
		};
	};
	_queryResult = call compile _queryResult;
	if(EQUAL(SEL(_queryResult,0),0)) exitWith {diag_log format ["extDB2: Protocol Error: %1", _queryResult]; []};
	_return = SEL(_queryResult,1);
	if(!_multiarr && count _return > 0) then {
		_return = SEL(_return,0);
	};

	_return;
};
publicVariable "SD_DB_ASYNC";


SD_Client_InsertPlayer = {
	[getPlayerUID player, player] remoteExec ["SD_DB_insertData",2];
};
publicVariable "SD_Client_InsertPlayer";

SD_Client_loadData = {
	SD_Rank = _this select 0;
	SD_Wins = _this select 1;
	SD_Kills = _this select 2;
	SD_Death = _this select 3;
	SD_XP = _this select 4;
	SD_XPNeeded = _this select 5;

	SD_Client_StatsLoaded = true;
};
publicVariable "SD_Client_loadData";

SD_DB_fetchData = {
	private ["_uid", "_query", "_result", "_curTime", "_tmp", "_tmp2"];
	_uid = _this select 0;
	_ownerID = _this select 1;
	if(isNull _ownerID) exitWith {diag_log "Owner ID is NULL";};
	_ownerID = owner _ownerID;

	_query = format["SELECT rank, wins, kills, death, xp, xp_needed FROM data WHERE pid='%1'", _uid];

	_curTime = diag_tickTime;
	_result = [_query,2] call SD_DB_ASYNC;

	diag_log "------------- Fetch Data Request -------------";
	diag_log format["QUERY: %1",_query];
	diag_log format["Time to complete: %1 (in seconds)",(diag_tickTime - _curTime)];
	diag_log format["Result: %1",_result];
	diag_log "------------------------------------------------";

	if(count _result isEqualTo 0) exitWith {
		[] remoteExec ["SD_Client_InsertPlayer",_ownerID];
		[_uid, _ownerID] remoteExec ["SD_DB_insertData",2];
	};

	_result remoteExec ["SD_Client_loadData",_ownerID];
};
publicVariable "SD_DB_fetchData";

SD_DB_insertData = {
  	_pid = _this select 0;
	_ownerID = _this select 1;
	_name = name _ownerID;
	if(isNull _ownerID) exitWith {diag_log "Owner ID is NULL";};
	
  	_query = format["INSERT INTO data (pid, name) VALUES ('%1','%2')", _pid,_name];

  	if(_query == "") exitWith {};

  	[_query,1] call SD_DB_ASYNC;

  	[_pid,_ownerID] remoteExec ["SD_DB_fetchData",2];
};
publicVariable "SD_DB_insertData";


SD_DB_partialSync = {
	private ["_query","_mode", "_value1", "_value2", "_data"];
	params ["_mode", "_data", "_pid"];

	switch (_mode) do {
		case 0: { //Update kills
			_data = [_data] call SD_safeNumber;
			_query = format["UPDATE Data SET kills='%1' WHERE pid='%2'", _data, _pid];
		};
		case 1: { //Update Death
			_data = [_data] call SD_safeNumber;
			_query = format["UPDATE Data SET Death='%1' WHERE pid='%2'", _data, _pid];
		};
		case 2: { //Update Wins
			_data = [_data] call SD_safeNumber;
			_query = format["UPDATE Data SET Wins='%1' WHERE pid='%2'", _data, _pid];
		};
		case 3: { //Update xp
			_data = [_data] call SD_safeNumber;
			_query = format["UPDATE Data SET xp='%1' WHERE pid='%2'", _data, _pid];
		};
		case 4: { //Update xp needed
			_data = [_data] call SD_safeNumber;
			_query = format["UPDATE Data SET xp_needed='%1' WHERE pid='%2'", _data, _pid];
		};
		case 5: { //Update rank
			_data = [_data] call SD_safeNumber;
			_query = format["UPDATE Data SET Rank='%1' WHERE pid='%2'", _data, _pid];
		};
	};

	if(_query == "") exitWith {};

	[_query,1] call SD_DB_ASYNC;
};
publicVariable "SD_DB_partialSync";
