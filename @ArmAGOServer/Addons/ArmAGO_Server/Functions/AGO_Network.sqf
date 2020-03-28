/*
Script File Author: Nais
Script File Mod: ArmA GO
Script File: AGO_Network.sqf

Description:
Networking
*/

["AGO_Msg_Global", {
	private ["_msg"];
	_msg = _this select 0;
	[_msg] remoteExec ["AGO_Global_Msg"];
}] call AGO_Function;

["AGO_Global_Msg", {
	private ["_msg"];
	_msg = _this select 0;
	systemChat _msg;
}] call AGO_Function;

["AGO_PlaySound_Global_Players", {
	private ["_sound"];
	_sound = _this select 0;
	[_sound] remoteExec ["AGO_Global_PlaySound_Players"];
}] call AGO_Function;

["AGO_PlaySound_Global_Object", {
	private ["_sound","_object"];
	_object = _this select 0;
	_sound = _this select 1;
	[_object,_sound] remoteExec ["AGO_Global_PlaySound_Object"];
}] call AGO_Function;

["AGO_Global_PlaySound_Object", {
	private ["_sound","_object"];
	_object = _this select 0;
	_sound = _this select 1;
	call compile format ["%1 say3D '%2'",_object,_sound];	
}] call AGO_Function;

["AGO_Global_PlaySound_Players", {
	private ["_so"];
	_so = _this select 0;
	player say3D _so;
}] call AGO_Function;

["AGO_PlaySound_Global_Player", {
	private["_player","_sound"];
	_player = _this select 0;
	_sound = _this select 1;
	[_player,_sound] remoteExec ["AGO_Global_playSound_Player"];
}] call AGO_Function;

["AGO_Global_playSound_Player", {
	private ["_player","_sound","_player"];
	_player = _this select 0;
	_sound = _this select 1;
    _player say3d _sound;
}] call AGO_Function;

["AGO_SwitchAnim_Global", {
	private ["_move","_cmd","_player"];
	_move = _this select 0;
	_cmd = _this select 1;
	_player = player;
	[_move,_cmd,_player] remoteExec ["AGO_Global_SwitchAnim"];	
}] call AGO_Function;

["AGO_Global_SwitchAnim", {
	private ["_move","_cmd","_player"];
	_move = _this select 0;
	_cmd = _this select 1;
	_player = _this select 2;

	call compile format ["_player %1 '%2'",_cmd,_move];
}] call AGO_Function;

["AGO_ServerLog",{
	params["_log"];

	[_log] remoteExec ["AGO_ServerLog_do",2];
}] call AGO_Function;

["AGO_ServerLog_do",{
	params["_log"];

	diag_log format ["::SERVER LOGGING:: %1",_log];
},true] call AGO_Function;