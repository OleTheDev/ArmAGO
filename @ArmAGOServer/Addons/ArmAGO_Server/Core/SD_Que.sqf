/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_Que.sqf
*/

SD_Que_Dialog = {
	closeDialog 1;
	createDialog "RPP_QueMenu";
	disableSerialization;

	buttonSetAction [1600, "[] call SD_Que_JoinBlue;"];
	buttonSetAction [1601, "[] call SD_Que_JoinRed;"];
	buttonSetAction [1602, "[] call SD_Que_Ready;"];

	{
		_rdy = "";
		if (_x select 1 getVariable "SD_PlayerReady") then {
			_rdy = "Ready";
		} else {
			_rdy = "Not Ready";
		};
		lbAdd [1500, format ["%1 (%2)",_x select 0,_rdy]];
	} foreach SD_TeamBlue;

	{
		_rdy = "";
		if (_x select 1 getVariable "SD_PlayerReady") then {
			_rdy = "Ready";
		} else {
			_rdy = "Not Ready";
		};
		lbAdd [1501, format ["%1 (%2)",_x select 0,_rdy]];
	} foreach SD_TeamRed;

	_text = uiNameSpace getVariable ["RPP_QueMenu",displayNull];
	_qued = _text displayCtrl 1002;
	_qued ctrlSetText format["%1/10 In Que",SD_InQue];
};
publicVariable "SD_Que_Dialog";

SD_Que_JoinBlue = {
	private ["_r","_b"];

	if (SD_TeamBlueCount >= SD_MaxQue) exitWith {
		hint "This team is currently full.";
	};

	_r = true;
	_b = false;

	{
		_name = _x select 0;
		if (name player == _name) exitWith {
			_r = false;
		};
	} count SD_TeamBlue;

	{
		_name = _x select 0;
		if (name player == _name) exitWith {
			_b = true;
		};
	} count SD_TeamRed;

	if (!(_r)) exitWith {
		hint "You are already in Team Blue.";
	};

	if (_b) then {
		SD_TeamRed = SD_TeamRed - [ [name player,player] ];
		SD_InQue = SD_InQue - 1;
		SD_TeamRedCount = SD_TeamRedCount - 1;
		publicVariable "SD_TeamRed";
		publicVariable "SD_InQue";
		publicVariable "SD_TeamRedCount";
		player setVariable ["SD_TeamRed",false,true];

		systemChat "Left Team Red to join Team Blue.";
	};


	SD_TeamBlue = SD_TeamBlue + [ [name player,player] ];
	SD_InQue = SD_InQue + 1;
	SD_TeamBlueCount = SD_TeamBlueCount + 1;
	publicVariable "SD_TeamBlue";
	publicVariable "SD_InQue";
	publicVariable "SD_TeamBlueCount";

	player setVariable ["SD_TeamBlue",true,true];

	systemChat "You are now in a que for Team Blue, Please click the ready up button when you are ready to play.";

	[] call SD_Que_Dialog;
};
publicVariable "SD_Que_JoinBlue";

SD_Que_JoinRed = {
	private ["_r","_b"];

	if (SD_TeamRedCount >= SD_MaxQue) exitWith {
		hint "This team is currently full.";
	};

	_r = true;
	_b = false;

	{
		_name = _x select 0;
		if (name player == _name) exitWith {
			_r = false;
		};
	} count SD_TeamRed;

	{
		_name = _x select 0;
		if (name player == _name) exitWith {
			_b = true;
		};
	} count SD_TeamBlue;

	if (!(_r)) exitWith {
		hint "You are already in Team Red.";
	};

	if (_b) then {
		SD_TeamBlue = SD_TeamBlue - [ [name player,player] ];
		SD_InQue = SD_InQue - 1;
		SD_TeamBlueCount = SD_TeamBlueCount - 1;
		publicVariable "SD_TeamBlue";
		publicVariable "SD_InQue";
		publicVariable "SD_TeamBlueCount";
		player setVariable ["SD_TeamBlue",false,true];

		systemChat "Left Team Blue to join Team Red.";
	};

	SD_TeamRed = SD_TeamRed + [ [name player,player] ];
	SD_InQue = SD_InQue + 1;
	SD_TeamRedCount = SD_TeamRedCount + 1;
	publicVariable "SD_TeamRed";
	publicVariable "SD_InQue";
	publicVariable "SD_TeamRedCount";

	player setVariable ["SD_TeamRed",true,true];

	systemChat "You are now in a que for Team Red, Please click the ready up button when you are ready to play.";

	[] call SD_Que_Dialog;
};
publicVariable "SD_Que_JoinRed";

SD_Que_Ready = {
	if (!(player getVariable "SD_PlayerReady")) then {
		player setVariable ["SD_PlayerReady",true,true];

		SD_Ready = SD_Ready + 1;
		publicVariable "SD_Ready";

		hint "You are now ready to play.";
	} else {
		player setVariable ["SD_PlayerReady",false,true];

		SD_Ready = SD_Ready - 1;
		publicVariable "SD_Ready";

		hint "You are nolonger ready.";
	};

	[] call SD_Que_Dialog;
};
publicVariable "SD_Que_Ready";