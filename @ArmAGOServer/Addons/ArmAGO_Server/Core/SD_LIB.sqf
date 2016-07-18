/*
Script File made by: Lifeman
Script File made for: Lifeman's S&D
Script File name: SD_LIB.sqf
*/
SD_Message_Global = {
	private ["_msg_get","_msg"];
	_msg = _this select 0;
	[_msg] remoteExec ["SD_Message_Get"];
};
publicVariable "SD_Message_Global";

SD_Message_Get = {
	private ["_msg"];
	_msg = _this select 0;
	systemChat _msg;
};
publicVariable "SD_Message_Get";

SD_TeamWon = {
	_Team = _this select 0;
	[_Team] remoteExec ["SD_WinningTeam"];
};
publicVariable "SD_TeamWon";

SD_WinningTeam = {
	private ["_Team"];
	_Team = _this select 0;
	switch (_Team) do { 
		case "Team Red": {
			if (player getVariable "SD_TeamRed") then {
				player sidechat format ["You earned $%1 For winning a round.",SD_WinningBonus];
				SD_Cash = SD_Cash + SD_WinningBonus;
				SD_XP = SD_XP + 10;
			} else {
				player sideChat format ["You lost the round and eanred $%1 for losing.",SD_LosingBonus];
				SD_Cash = SD_Cash + SD_LosingBonus;
				SD_XP = SD_XP + 1;
			};
		}; 
		case "Team Blue": {
			if (player getVariable "SD_TeamBlue") then {
				player sidechat format ["You earned $%1 For winning a round.",SD_WinningBonus];
				SD_Cash = SD_Cash + SD_WinningBonus;
				SD_XP = SD_XP + 10;
			} else {
				player sideChat format ["You lost the round and eanred $%1 for losing.",SD_LosingBonus];
				SD_Cash = SD_Cash + SD_LosingBonus;
				SD_XP = SD_XP + 1;
			};
		}; 
		default {
			player sideChat "Error sending out Winning/Losing bonus to team.";
		};	 
	};
};
publicVariable "SD_WinningTeam";

SD_safeNumber = {
  private ["_number","_mod","_digots","_digitsCount","_modBase","_numberText"];

  _number = [_this,0,0,[0]] call bis_fnc_param;
  _mod = [_this,1,3,[0]] call bis_fnc_param;

  _digits = _number call bis_fnc_numberDigits;
  _digitsCount = count _digits - 1;

  _modBase = _digitsCount % _mod;
  _numberText = "";
  {
  	_numberText = _numberText + str _x;
  	if ((_foreachindex - _modBase) % (_mod) == 0 && _foreachindex != _digitsCount) then {_numberText = _numberText + "";};
  } forEach _digits;
  _numberText;
};
publicVariable "SD_safeNumber";

SD_safeString = {
  private["_string","_filter"];
  _string = [_this,0,"",[""]] call BIS_fnc_param;
  _filter = "'/\`:|;,{}-""<>";

  _string = toArray _string; //Blow it up to an array
  _filter = toArray _filter; //Blow it up to an array

  {
  	if(_x in _filter) then {
  		_string set[_forEachIndex,-1];
  	};
  } forEach _string;

  _string = _string - [-1];
  toString _string;
};
publicVariable "SD_safeString";

SD_bool = {
  private["_bool","_mode"];
  _bool = [_this,0,0,[false,0]] call BIS_fnc_param;
  _mode = [_this,1,0,[0]] call BIS_fnc_param;

  switch (_mode) do {
  	case 0: {
  		if(_bool isEqualType 0) exitWith {0};
  		if(_bool) then {1} else {0};
  	};

  	case 1: {
  		if(!(_bool isEqualType 0)) exitWith {false};
  		switch (_bool) do {
  			case 0: {false};
  			case 1: {true};
  		};
  	};
  };

};
publicVariable "SD_bool";
